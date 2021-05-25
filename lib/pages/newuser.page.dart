import 'package:flutter/material.dart';

import '../services/authenticate.dart';
import '../widget/singup.dart';
import '../widget/textNew.dart';
import '../widget/userOld.dart';
import 'home.page.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SingUp(),
                        TextNew(),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Enter Your Username' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  decoration: new InputDecoration(
                    labelText: 'Username',
                    contentPadding: const EdgeInsets.only(left: 50, right: 50),
                    errorStyle: TextStyle(fontSize: 20),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: new InputDecoration(
                    labelText: 'Email',
                    contentPadding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    errorStyle: TextStyle(fontSize: 20),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) =>
                      val.length < 6 ? 'Enter a Password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: new InputDecoration(
                    labelText: 'Password',
                    contentPadding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    errorStyle: TextStyle(fontSize: 20),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                RaisedButton(
                  padding: const EdgeInsets.only(
                      top: 35, right: 40, left: 190, bottom: 35),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[300],
                            blurRadius:
                                10.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  name, email, password);
                          if (result == null) {
                            setState(
                                () => error = 'Please supply a valid email');
                          } else {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(result: result.toString())));
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                UserOld(),
              ]))),
    );
  }
}
