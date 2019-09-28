import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerApp extends StatefulWidget {
  final String title;

  const ImagePickerApp({
    @required this.title,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return ImagePickerAppState();
  }
}

class ImagePickerAppState extends State<ImagePickerApp> {
  File _imageFile;
  String filePath;
  Uri fileURI;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(
      source: source,
      maxWidth: 400.0,
      maxHeight: 400.0,
    ).then((File image) {
      setState(() {
        _imageFile = image;
        filePath = image.path;
        fileURI = image.uri;
      });
//      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _getImage(context, ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.photo_camera,
                        size: 30.0,
                        color: Colors.deepOrange,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      Text(
                        "Use Camera",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _getImage(context, ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera,
                        size: 30.0,
                        color: Colors.deepOrange,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      Text(
                        "Use Gallery",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.deepOrange,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.camera_alt, color: Colors.deepPurple),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Add Image",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
                onPressed: () {
                  _openImagePicker(context);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(_imageFile == null
                  ? "Please pick an image !!"
                  : "File Path : ${filePath} \n\nFile URI : ${fileURI}"),
              _imageFile == null
                  ? Container()
                  : Image.file(
                      _imageFile,
                      alignment: Alignment.topCenter,
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
