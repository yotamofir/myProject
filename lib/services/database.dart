import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({ this.uid });

  // ignore: non_constant_identifier_names
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');


  Future updateUserData(String name, String email, String password) async{
    return await collectionReference.doc(uid).set({
      'name' : name,
      'email' : email,
      'password' : password,
    });
  }
}