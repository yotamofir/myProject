import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/authenticate.dart';
import 'profile.page.dart';

class editProfile extends StatefulWidget {
  final String result;
  editProfile({Key key, @required this.result}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState(result);
}

class _editProfileState extends State<editProfile> {
  final AuthService _auth = AuthService();
  String uid;
  _editProfileState(this.uid);

  String name = '';
  String newPassword = '';
  String oldPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    String uid = widget.result;

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('user').doc(uid);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() => name = val);
                },
                style: new TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'please enter your new username',
                  contentPadding: const EdgeInsets.only(left: 50, right: 50),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  labelText: 'New Username',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 40)),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => newPassword = val);
                },
                style: new TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'please enter your new password',
                  contentPadding: const EdgeInsets.only(left: 50, right: 50),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 40)),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => oldPassword = val);
                },
                style: new TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'please enter your old password',
                  contentPadding: const EdgeInsets.only(left: 50, right: 50),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  labelText: 'Old Password (Required)',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () async {
                  User currentUser = FirebaseAuth.instance.currentUser;
                  DocumentSnapshot snapshot = await FirebaseFirestore.instance
                      .collection('user')
                      .doc(uid)
                      .get();
                  if (snapshot.data()['password'].toString() !=
                      oldPassword.trim()) {
                    setState(() => error = 'Incorrect old password');
                  } else {
                    if (name.trim() != "") {
                      await documentReference.update({'name': name.trim()});
                    }
                    if (newPassword.trim() != "") {
                      await documentReference
                          .update({'password': newPassword.trim()});
                      currentUser.updatePassword(newPassword.trim());
                    }
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (ProfilePage(result: uid))));
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 30),
                ),
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                padding: EdgeInsets.fromLTRB(65, 25, 65, 25),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
