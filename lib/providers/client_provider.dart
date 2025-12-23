import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/base_provider.dart';

class ClientProvider extends BaseViewModel {
  String notes = '';
  List<ClientModel> _clients = [];

  List<ClientModel> get clients => _clients;

  Future<void> loadClients() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      setLoading(ViewState.Busy);

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('clients')
          .get();

      _clients = snapshot.docs
          .map((doc) => ClientModel.fromMap(doc.id, doc.data()))
          .toList();

      log("Clients loaded ${_clients.length}");

      setLoading(ViewState.Success);
    } catch (e) {
      setError("Error loading client $e");
      setLoading(ViewState.Error);
    }
  }

  Future<void> updateClientNotes(String clientId, String newNotes) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      setLoading(ViewState.Busy);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('clients')
          .doc(clientId)
          .update({'notes': newNotes.trim()});

      final index = _clients.indexWhere((c) => c.id == clientId);
      if (index != -1) {
        _clients[index] = _clients[index].copyWith(notes: newNotes.trim());
        notifyListeners();
      }

      setLoading(ViewState.Success);
    } catch (e) {
      setError("Error adding client $e");
      setLoading(ViewState.Error);
    }
  }

  Future<void> addClient(ClientModel client) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      setLoading(ViewState.Busy);

      final ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('clients')
          .add(client.toMap());

      client = ClientModel.fromMap(ref.id, client.toMap());
      _clients.add(client);

      setLoading(ViewState.Success);
    } catch (e) {
      setError("Error adding client $e");
      setLoading(ViewState.Error);
    }
  }

  Future<void> updateClient(ClientModel client) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      setLoading(ViewState.Busy);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('clients')
          .doc(client.id)
          .update(client.toMap());

      final index = _clients.indexWhere((c) => c.id == client.id);
      if (index != -1) {
        _clients[index] = client;
      }
      setLoading(ViewState.Success);
    } catch (e) {
      setError("Error updating client $e");
      setLoading(ViewState.Error);
    }
  }

  Future<void> deleteClient(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      setLoading(ViewState.Busy);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('clients')
          .doc(id)
          .delete();

      _clients.removeWhere((i) => i.id == id);
      setLoading(ViewState.Success);
    } catch (e) {
      setError("Error deleting client $e");
      setLoading(ViewState.Error);
    }
  }
}
