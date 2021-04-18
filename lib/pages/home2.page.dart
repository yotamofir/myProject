import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:BookIt/pages/addImage.page.dart';


class HomePage2 extends StatefulWidget {


  @override
  _HomePageState2 createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Gallery',
          style: TextStyle(
              fontSize: 28
          ),),
        centerTitle: true,
        backgroundColor: Colors.black45,
        actions: [
          FlatButton(
            onPressed: () {

            },
            child: Text(
              'profile',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.indigo,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddImage()));
              }),
        ),
      ),
    );
  }
}
