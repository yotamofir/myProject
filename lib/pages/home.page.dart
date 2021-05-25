import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'addImage.page.dart';
import 'fullImg.page.dart';
import 'login.page.dart';
import 'profile.page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final String result;
  HomePage({Key key, @required this.result}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(result);
}

class _HomePageState extends State<HomePage> {
  String uid;
  _HomePageState(this.uid);
  CollectionReference imgColRef;

  void initState() {
    imgColRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.result;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black45,
        title: Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'log out',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
            Text(
              'Gallery',
              style: TextStyle(fontSize: 28),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (ProfilePage(result: uid))));
              },
              child: Text(
                'profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.indigo,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddImage(result: uid)));
              }),
        ),
      ),
      body: StreamBuilder(
        stream: imgColRef.snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data?.documents == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Hero(
              tag: 'imageHero',
              child: Container(
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    itemCount: snapshot.data.documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) => GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            child: FadeInImage.memoryNetwork(
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                                image:
                                    snapshot.data.documents[index].get('url')),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return fullImg(
                                  snapshot.data.documents[index].get('url'),
                                  uid);
                            }));
                          },
                        )),
              ));
        },
      ),
    );
  }
}
