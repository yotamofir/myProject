import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({ this.uid });

  // ignore: non_constant_identifier_names
  final CollectionReference BookItCollection = Firestore.instance.collection('user');


  Future updateUserData(String name, String email, String password) async{
    Firestore.instance.collection('user').document(uid).collection('book').add(null);
    return await BookItCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'password' : password,
    });
  }


}