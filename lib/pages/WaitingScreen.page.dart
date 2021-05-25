import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Text(
          '     Photo    \n  Gallery',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            fontSize: 88,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
