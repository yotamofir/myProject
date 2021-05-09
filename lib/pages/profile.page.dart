

import 'package:BookIt/pages/addImage.page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  Map data;
  final String result;
  ProfilePage({Key key, @required this.result}) : super(key: key);



  @override
  _ProfilePageState createState() => _ProfilePageState(result);
}

class _ProfilePageState extends State<ProfilePage> {

  Map data;
  String uid;
  _ProfilePageState(this.uid);

  Future<List<String>> fetchData(String uid) async{
    String info = '';

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('user').doc(uid).get();

    info += ('\n Username: ' + snapshot.data()['name'].toString()) + (',  Email: ' + snapshot.data()['email'].toString());
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
          child: Icon(Icons.edit, size: 35),
          onPressed: () async{
        //    Navigator.push(context,
        //        MaterialPageRoute(builder: (context) => NewBook(result: uid)));
          },
        ),
      ),
    );
  }
}
