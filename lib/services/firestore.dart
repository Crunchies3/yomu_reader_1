import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference library = FirebaseFirestore.instance.collection('manga_library');
  final CollectionReference history = FirebaseFirestore.instance.collection('manga_history');


  Future<void> addUser(UserCredential userCredential, String username){
    return users.doc(userCredential.user!.email).set({
      'email':userCredential.user!.email,
      'username':username
    });
  }
}