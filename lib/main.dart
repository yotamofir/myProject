import 'package:BookIt/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:BookIt/pages/login.page.dart';
import 'package:BookIt/pages/newBook.page.dart';
import 'package:BookIt/pages/friends.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      //FriendPage(result: 'oK0GAQJxq7dxheln4g636ZNgnAz2'),
      debugShowCheckedModeBanner: false,
    );
  }
}

