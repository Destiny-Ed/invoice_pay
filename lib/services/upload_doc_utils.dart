import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:invoice_pay/providers/auth_provider.dart';

class UploadDocResultModel {
  final ViewState state;
  final String fileUrl;
  UploadDocResultModel({required this.state, required this.fileUrl});
}

Future<UploadDocResultModel> uploadDocumentToServer(String docPath) async {
  UploadTask uploadTask;

  final docName = docPath.split('/').last;

  log("Uploading document to server");

  try {
    Reference ref = FirebaseStorage.instance.ref().child('/$docName');

    uploadTask = ref.putFile(File(docPath));

    TaskSnapshot snapshot = await uploadTask.whenComplete(
      () => log("Task completed"),
    );

    final downloadUrl = await snapshot.ref.getDownloadURL();

    return Future.value(
      UploadDocResultModel(state: ViewState.Success, fileUrl: downloadUrl),
    );
  } on FirebaseException catch (error) {
    log("F-Error uploading image : $error");

    return Future.value(
      UploadDocResultModel(
        state: ViewState.Error,
        fileUrl: 'F-Error uploading image',
      ),
    );
  } catch (error) {
    log("Error uploading image : $error");

    return Future.value(
      UploadDocResultModel(
        state: ViewState.Error,
        fileUrl: 'Error uploading image',
      ),
    );
  }
}
