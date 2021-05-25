import 'package:flutter/material.dart';

import '../services/authenticate.dart';
import '../widget/first.dart';
import '../widget/textLogin.dart';
import '../widget/verticalText.dart';
import 'home.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      VerticalText(),
                      TextLogin(),
                    ],
                  ),
                ],
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: new InputDecoration(
                  labelText: 'Email',
                  contentPadding:
                      const EdgeInsets.only(top: 50, left: 50, right: 50),
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
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: new InputDecoration(
                  labelText: 'Password',
                  contentPadding:
                      const EdgeInsets.only(top: 50, left: 50, right: 50),
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
                    top: 40, right: 50, left: 200, bottom: 50),
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
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() => error = 'Incorrect email or password');
                        } else {
                          print(result);
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
                          'Login',
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
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
              FirstTime(),
            ],
          ),
        ),
      ),
    );
  }
}
