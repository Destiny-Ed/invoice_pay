import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pay/models/client_model.dart';

class ClientProvider extends ChangeNotifier {
  List<ClientModel> _clients = [];

  List<ClientModel> get clients => _clients;

  Future<void> loadClients() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('clients')
        .get();

    _clients = snapshot.docs.map((doc) => ClientModel.fromMap(doc.id, doc.data())).toList();
    notifyListeners();
  }

  Future<void> addClient(ClientModel client) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('clients')
        .add(client.toMap());

    client = ClientModel.fromMap(ref.id, client.toMap());
    _clients.add(client);
    notifyListeners();
  }

  Future<void> updateClient(ClientModel client) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('clients')
        .doc(client.id)
        .update(client.toMap());

    final index = _clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _clients[index] = client;
      notifyListeners();
    }
  }
}