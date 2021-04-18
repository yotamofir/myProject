

import 'package:BookIt/pages/addImage.page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class FriendPage extends StatefulWidget {
  Map data;
  final String result;
  FriendPage({Key key, @required this.result}) : super(key: key);



  @override
  _FriendPageState createState() => _FriendPageState(result);
}

class _FriendPageState extends State<FriendPage> {

  Map data;
  String uid;
  _FriendPageState(this.uid);

  Future<List<String>> fetchData(String uid) async{
    String info = '';

    DocumentSnapshot snapshot = await Firestore.instance.collection('user').document(uid).get();

    info += ('\n Username: ' + snapshot.data['name'].toString()) + (', Email: ' + snapshot.data['email'].toString());
    List<String> spec_list = info.split(", ");

    return spec_list;
  }


  @override
  Widget build(BuildContext context) {
    String uid = widget.result;


    //print(books);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Profile',
          style: TextStyle(
              fontSize: 28
          ),),
        centerTitle: true,
        backgroundColor: Colors.black45,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child:GestureDetector(

              onTap: () { /* Write listener code here */ },
                child: Icon(
                  Icons.edit,
                  size: 30,
            // add custom icons also
          ),
        ),
      ),
      ],
      ),

      body: Container(


        child: Column(
          children: [






            FutureBuilder<List<String>>(
                future: fetchData(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data[0] + '\n' + snapshot.data[1],
                      style: TextStyle(
                          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold
                      ),
                    );



                  } else {
                    return Text(
                      'Loading...',
                      style: TextStyle(
                          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold
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
        //    Navigator.push(context,
        //        MaterialPageRoute(builder: (context) => NewBook(result: uid)));
          },
        ),
      ),
    );
  }
}
