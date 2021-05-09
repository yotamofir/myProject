import 'package:BookIt/models/user.dart';
import 'package:BookIt/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuth _userFromFirebaseUser(User user){
    return user != null ? UserAuth(uid: user.uid) : null;
  }

  Future registerWithEmailAndPassword(String name, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(name, email, password);
      return _userFromFirebaseUser(user).uid;
    } catch(e){
        print(e.toString());
        return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;
      return _userFromFirebaseUser(user).uid;
    } catch(e){
      print(e.toString());
      return null;
    }
  }



}