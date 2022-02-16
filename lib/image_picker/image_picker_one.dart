import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOne extends StatefulWidget {
  const ImagePickerOne({Key? key}) : super(key: key);

  @override
  _ImagePickerOneState createState() => _ImagePickerOneState();
}

class _ImagePickerOneState extends State<ImagePickerOne> {
   File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
             child: Image.file(
               imageFile!,
               fit: BoxFit.cover,
             ),
           ),
            ElevatedButton(
                onPressed: (){
                  _imagePickGallery();
                },
                child: Text('Image pick from gallery')
            )
          ],
        ),
      ),
    );
  }
  _imagePickGallery()async{
     PickedFile? pickedFile=await ImagePicker().getImage(
          source: ImageSource.gallery,
          maxHeight: 1800,
        maxWidth: 1800
      );
     if(pickedFile!=null){
       setState(() {
         imageFile=File(pickedFile.path);
       });

     }

  }
}
