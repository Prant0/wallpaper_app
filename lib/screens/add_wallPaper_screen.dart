
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWallpaperScreen extends StatefulWidget {
  @override
  _AddWallpaperScreenState createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {

  File _image;
  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  List<ImageLabel> detectLabel;

  @override
  void dispose() {
    labeler.close();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Wallpaper"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              InkWell(
                onTap: _loadImage,
                child: _image != null ? Image.file(_image): Image(image: AssetImage('assets/ph.png'),fit: BoxFit.cover,width: double.infinity,),
              ),

              SizedBox(
                height: 20.0,
              ),
              Text("Click On Image To Upload your Wallpaper",style: TextStyle(fontSize: 18),),

              detectLabel !=null ? Padding(
                padding: EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 20,
                  children: detectLabel.map((label) {
                    return Chip(

                      padding: EdgeInsets.symmetric(horizontal: 10),
                      label: Text(label.text),
                    );
                  }).toList(),
                ),
              ) :Container()
            ],
          ),
        ),
      ),
    );
  }

  void _loadImage()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    List<ImageLabel> labels = await labeler.processImage(visionImage);


    /*for(var label in labels){
      print("${label.text} [${label.confidence}]");
    }*/
    setState(() {
      detectLabel=labels;
      _image=image;
    });
  }
}
