import 'package:flutter/material.dart';
import 'package:login_minimalist/pages/first.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
