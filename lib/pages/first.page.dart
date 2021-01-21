import 'package:flutter/material.dart';
import 'package:login_minimalist/widget/button.dart';
import 'package:login_minimalist/widget/loginButton.dart';
import 'package:login_minimalist/widget/signInButton.dart';
import 'package:login_minimalist/widget/first.dart';
import 'package:login_minimalist/widget/forgot.dart';
import 'package:login_minimalist/widget/inputEmail.dart';
import 'package:login_minimalist/widget/password.dart';
import 'package:login_minimalist/widget/textLogin.dart';
import 'package:login_minimalist/widget/verticalText.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  TextLogin(),
                ]),
                LoginButton(),
                SigninButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}