import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ViewState { Idle, Busy, Success, Error }

abstract class _AuthenticationProviderUseCase {
  Future<void> loginUser();
  Future<void> registerUser();
  Future<void> logoutUser();
  Future<void> deleteAccount();
  Future<void> forgotPassword();
}

class AuthenticationProviderImpl extends ChangeNotifier
    implements _AuthenticationProviderUseCase {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  ViewState state = ViewState.Idle;
  String message = '';

  bool _isTermsAccepted = false;

  bool get isTermsAccepted => _isTermsAccepted;

  set isTermsAccepted(bool value) {
    _isTermsAccepted = value;
    _updateState();
  }

  String tempPasswordForDeletion = '';

  @override
  Future<void> loginUser() async {
    state = ViewState.Busy;
    message = 'Preparing your account...';
    _updateState();

    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      state = ViewState.Success;
      message = 'Welcome back, ${result.user!.displayName}';

      _updateState();
    } on SocketException catch (_) {
      state = ViewState.Error;
      message = 'Network error. Please try again later.';
      _updateState();
    } on FirebaseAuthException catch (e) {
      state = ViewState.Error;
      message = e.code;
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      message = 'Error creating account. Please try again later.';
      _updateState();
    }
  }

  @override
  Future<void> logoutUser() async {
    // await NotificationService.cancelAll();
    // await Purchases.logOut();
    return await firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }

    state = ViewState.Busy;
    message = "Deleting your account...";
    _updateState();

    try {
      // 1. Re-authenticate user (REQUIRED for delete)
      await _reAuthenticateUser();

      // 2. Delete user-related data from Firestore (batch for safety)
      await _deleteUserDataFromFirestore(user.uid);

      // 3. Log out from RevenueCat
      // await Purchases.logOut();

      // 4. Cancel all notifications
      // await NotificationService.cancelAll();

      // 5. Finally: Delete the Firebase Auth user
      await user.delete();

      // 6. Optional: Clear local state
      state = ViewState.Success;
      message = "Account deleted successfully";
      _updateState();
      return;
    } on FirebaseAuthException catch (e) {
      String errorMsg = _handleAuthError(e);
      state = ViewState.Error;
      message = errorMsg;
      _updateState();
      rethrow;
    } catch (e) {
      state = ViewState.Error;
      message = "Failed to delete account: ${e.toString()}";
      _updateState();
      rethrow;
    }
  }

  // Re-authenticate user before deletion
  Future<void> _reAuthenticateUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final email = user.email;

    if (email == null) throw Exception("User has no email");

    if (tempPasswordForDeletion.isEmpty) {
      throw Exception("Password required for account deletion");
    }

    final cred = EmailAuthProvider.credential(
      email: email,
      password: tempPasswordForDeletion,
    );

    await user.reauthenticateWithCredential(cred);

    // Clear it after use for security
    tempPasswordForDeletion = '';
  }

  // Comprehensive Firestore data cleanup
  Future<void> _deleteUserDataFromFirestore(String uid) async {
    final batch = FirebaseFirestore.instance.batch();

    // Delete or soft-delete main user document
    final userRef = FirebaseFirestore.instance.collection('user').doc(uid);
    final checkUser = await userRef.get();
    if (!checkUser.exists) return;
    batch.update(userRef, {
      "is_deleted": true,
      "date_deleted": FieldValue.serverTimestamp(),
      "email": FieldValue.delete(), // optional: anonymize
    });

    // Delete loans (or subcollections)
    final loansRef = FirebaseFirestore.instance.collection('loans').doc(uid);
    batch.delete(loansRef);

    // Add more collections if needed, e.g.:
    // final notificationsRef = FirebaseFirestore.instance.collection('notifications').doc(uid);
    // batch.delete(notificationsRef);

    // If you have subcollections (e.g. loans → loan_items), you MUST delete them recursively
    // Firestore does NOT support recursive delete natively → use Cloud Function or client-side loop

    await batch.commit();
  }

  // Helper to handle common auth errors
  String _handleAuthError(FirebaseAuthException e) {
    print(e.message);
    switch (e.code) {
      case 'requires-recent-login':
        return 'Please log in again before deleting your account.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-not-found':
      case 'invalid-credential':
        return 'Authentication failed. Please re-login and try again.';
      default:
        return 'Deletion failed: ${e.message}';
    }
  }

  Future<void> _updateUser(
    User? firebaseUser, {
    bool isDeleteUser = false,
  }) async {
    if (!isDeleteUser) {
      return await FirebaseFirestore.instance
          .collection('user')
          .doc(firebaseUser?.uid)
          .set({
            "email": firebaseUser?.email ?? "",
            "uid": firebaseUser?.uid,
            "platform": Platform.operatingSystem,
            "date_created": DateTime.now().toIso8601String(),
            "date_deleted": null,
            "is_deleted": false,
          });
    } else {
      return await FirebaseFirestore.instance
          .collection('user')
          .doc(firebaseUser?.uid)
          .update({
            "date_deleted": DateTime.now().toIso8601String(),
            "is_deleted": true,
          });
    }
  }

  Future<bool> isUserAvailable(User? firebaseUser) async {
    final userDetail = await FirebaseFirestore.instance
        .collection('user')
        .doc(firebaseUser?.uid)
        .get();

    if (!userDetail.exists || userDetail.get("is_deleted") == true) {
      return false;
    }
    return true;
  }

  @override
  Future<void> registerUser() async {
    state = ViewState.Busy;
    message = 'Creating your account...';

    _updateState();

    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      ///set username of user
      result.user!.updateDisplayName(userNameController.text.trim());

      state = ViewState.Success;
      message = 'Welcome, ${userNameController.text}';

      _updateState();
      unawaited(_updateUser(result.user));
    } on SocketException catch (_) {
      state = ViewState.Error;
      message = 'Network error. Please try again later.';
      _updateState();
    } on FirebaseAuthException catch (e) {
      state = ViewState.Error;
      message = e.code;
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      message = 'Error creating account. Please try again later.';
      _updateState();
    }
  }

  _updateState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  @override
  Future<void> forgotPassword() async {
    state = ViewState.Busy;
    message = 'Checking your account...';

    _updateState();

    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      state = ViewState.Success;
      message =
          'A password reset email link has been sent to ${emailController.text}';
      _updateState();
    } on SocketException catch (_) {
      state = ViewState.Error;
      message = 'Network error. Please try again later.';
      _updateState();
    } on FirebaseAuthException catch (e) {
      state = ViewState.Error;
      message = e.code;
      _updateState();
    } catch (e) {
      state = ViewState.Error;
      message = 'Error checking account. Please try again later.';
      _updateState();
    }
  }
}
