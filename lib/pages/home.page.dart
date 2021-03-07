

import 'package:BookIt/pages/newBook.page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  Map data;
  final String result;
  HomePage({Key key, @required this.result}) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState(result);
}

class _HomePageState extends State<HomePage> {

  Map data;
  String uid;
  _HomePageState(this.uid);

  Future<String> fetchData(String uid) async{
    String books = '';
    QuerySnapshot querySnapshot = await Firestore.instance.collection('user').document(uid).collection('book').getDocuments();
    print(querySnapshot.documents.length);
    if(querySnapshot.documents.length<1){
      return null;
    }else {
      for (int i = 0; i < querySnapshot.documents.length; i++) {
        books += (i + 1).toString() + '. Title: ' +
            querySnapshot.documents[i].data['title'].toString() + ', Author: ' +
            querySnapshot.documents[i].data['author'].toString() +
            ', Category: ' +
            querySnapshot.documents[i].data['category'].toString() +
            ', Year: ' + querySnapshot.documents[i].data['year'].toString() +
            '\n\n';
        print(books);
      }
      return books;
    }
  }


  @override
  Widget build(BuildContext context) {
    String uid = widget.result;


    //print(books);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('My Books',
        style: TextStyle(
          fontSize: 28
        ),),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Container(

        child: Column(
          children: [
            SizedBox(height: 50,),
            FutureBuilder<String>(
              future: fetchData(uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
                    ),
                  );
                } else {
                  return Text(
                    'You have no books now, please press the + to add one',
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 150,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.add, size: 40),
          onPressed: () async{
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewBook(result: uid)));
          },
        ),
      ),
    );
  }
}