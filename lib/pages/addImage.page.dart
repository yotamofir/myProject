import 'dart:io';
import 'package:BookIt/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Add Image',
          style: TextStyle(
              fontSize: 28
          ),),
        centerTitle: true,
        backgroundColor: Colors.black45,
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'upload',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: _image.length+1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return index == 0
              ? Center(
                  child: IconButton(
                    icon: Icon(Icons.add, size: 30),
                    onPressed: () {
                      chooseImage();
                      },
                  ),
                )
              : Container(margin: EdgeInsets.all(3),
                decoration: BoxDecoration(image: DecorationImage(image: FileImage(_image[index-1]))),
          );
        },
      )
    );
  }

  chooseImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
  }

  Future<void> retriveLostData() async{
    final LostData response = await picker.getLostData();
    if(response.isEmpty){
      return;
    }
    if(response.file != null){
      setState(() {
        _image.add(File(response.file.path));
      });
    }else{
      print(response.file);
    }
  }

}
