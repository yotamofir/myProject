import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class fullImg extends StatefulWidget {
  final String url;
  final String uid;
  fullImg(this.url, this.uid);
  @override
  _fullImgState createState() => _fullImgState();
}

class _fullImgState extends State<fullImg> {

  int _progress = 0;
  @override
  void initState(){
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress){
      setState(() {
        _progress = progress;
        if(_progress == 100){
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            child: Center(
              child: Hero(
                tag: 'imageHero',
                child: Image.network(widget.url),
              ),
            ),
            onTap: (){
              Navigator.of(context).pop();
            },
          )),
          Column(
            children: [
              Container(
                child: Text(
                  'Click the image for exit',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                  valueColor: new AlwaysStoppedAnimation(Colors.red),
                  value: _progress.toDouble() / 100,

                ),

              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () async{
                    await ImageDownloader.downloadImage(widget.url,
                      destination: AndroidDestinationType.custom(
                          directory: 'Downloads'));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
