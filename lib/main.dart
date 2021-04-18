import 'package:BookIt/pages/home.page.dart';
import 'package:BookIt/pages/home2.page.dart';
import 'package:flutter/material.dart';
import 'package:BookIt/pages/login.page.dart';
import 'package:BookIt/pages/addImage.page.dart';
import 'package:BookIt/pages/profile.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      HomePage2(),
      debugShowCheckedModeBanner: false,
    );
  }
}


