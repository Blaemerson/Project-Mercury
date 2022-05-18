import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmercury/models/contact.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addContact(
    Contact contact,
  ) async {
    await _firestore.collection('contacts').doc().set(contact.toJson());
  }
}
