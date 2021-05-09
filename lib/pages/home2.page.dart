import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:BookIt/pages/profile.page.dart';
import 'package:BookIt/pages/addImage.page.dart';
import 'package:transparent_image/transparent_image.dart';


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
          //    Navigator.of(context)
          //        .push(MaterialPageRoute(builder: (context) => (ProfilePage(result: null)));
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: (context, snapshot){
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
          : Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                itemCount: snapshot.data.documents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: snapshot.data.documents[index].get('url')),
                  );
                }),
          );
        },
      ),
    );
  }
}
