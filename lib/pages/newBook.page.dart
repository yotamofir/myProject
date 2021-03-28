import 'package:BookIt/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewBook extends StatefulWidget {
  final String result;
  NewBook({Key key, @required this.result}) : super(key: key);

  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {

  String title = '';
  String author = '';
  String category = '';
  int year = 0;
  final _formKey = GlobalKey<FormState>();

  updateBookData(String title, String author, String category, int year, String uid) async{
    CollectionReference collectionReference = Firestore.instance.collection('user').document(uid).collection('book');
    return await collectionReference.document().setData({
      'title' : title,
      'author' : author,
      'category' : category,
      'year' : year,
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.result;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Book',
          style: TextStyle(
              fontSize: 28
          ),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter the book title' : null,
                onChanged: (val){
                  setState(() => title = val);
                },
                decoration: new InputDecoration(
                  labelText: 'Book Title',
                  errorStyle: TextStyle(
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter the author' : null,
                onChanged: (val){
                  setState(() => author = val);
                },
                decoration: new InputDecoration(
                  labelText: 'Author',
                  errorStyle: TextStyle(
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter the category' : null,
                onChanged: (val){
                  setState(() => category = val);
                },
                decoration: new InputDecoration(
                  labelText: 'category',
                  errorStyle: TextStyle(
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),
              ),
              TextFormField(
                validator: (val) => int.parse(val) > 2021 || int.parse(val) < 1000 ? 'Enter valid year' : null,
                onChanged: (val){
                  setState(() => year = int.parse(val));
                },
                decoration: new InputDecoration(
                  labelText: 'year published',
                  errorStyle: TextStyle(
                      fontSize: 20
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                ),
              ),
              RaisedButton(
                padding: const EdgeInsets.only(top: 40, right: 50, left: 200, bottom: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: FlatButton(
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        updateBookData(title, author, category, year, uid);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage(result: uid)));
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
