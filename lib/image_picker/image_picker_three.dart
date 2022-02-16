import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/image_picker/homePage.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerThree extends StatefulWidget {
  final type;
  ImagePickerThree(this.type);
 // const ImagePickerThree({Key? key}) : super(key: key);

  @override
  _ImagePickerThreeState createState() => _ImagePickerThreeState(this.type);
}

class _ImagePickerThreeState extends State<ImagePickerThree> {
  var _image;
  var imagePicker;
  var type;

  _ImagePickerThreeState(this.type);



  @override
  void initState() {
    // TODO: implement initState
    imagePicker=new ImagePicker();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type==ImageSourceType.camera
        ?"Image from camera":"image from gallery"
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: ()async{
           var _source = type == ImageSourceType.camera?
           ImageSource.camera:
           ImageSource.gallery;
           XFile image= await imagePicker.pickImage(
               source: _source,imageQuality: 50,preferredCameraDevice: CameraDevice.front
           );
           setState(() {
             _image=File(image.path);
           });
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red[200],
            ),
            child: _image!=null?
                Image.file(
                  _image,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ):
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                  ),
                  child: Icon(Icons.camera_alt,color: Colors.grey[800],),

                )
          ),
        ),
      ),
    );
  }
}
