import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class FirebaseImageUpload extends StatefulWidget {
  const FirebaseImageUpload({Key? key}) : super(key: key);

  @override
  _FirebaseImageUploadState createState() => _FirebaseImageUploadState();
}

class _FirebaseImageUploadState extends State<FirebaseImageUpload> {

  String? singleImage;
  List<String> multipleImage=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image storage"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                singleImage!=null && singleImage!.isNotEmpty?
                    Image.network(
                    singleImage!,
                    height: 200,
                    ):SizedBox.shrink(),

                MaterialButton(
                    onPressed: ()async{
                    XFile? _image=await singleImagePick();
                    if(_image!=null && _image.path!.isNotEmpty){
                      singleImage = await UploadImage(_image);
                      setState(() {

                      });
                      print(await UploadImage(_image!));
                    }
                    },
                   color: Colors.blue,
                    textColor: Colors.white,
                  child: Text('Single Image'),
                ),
                SizedBox(height: 20,),
                MaterialButton(
                    onPressed: ()async{
                      List<XFile> _image=await multiImagePicker();
                      if(_image.isNotEmpty){
                        
                        multipleImage=await multiImageUpload(_image);
                        setState(() {

                        });
                      }
                    },
                   color: Colors.blue,
                    textColor: Colors.white,
                  child: Text('Multi Image'),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: multipleImage.map((e) =>
                        Image.network(
                            e,
                            height: 250,
                          width: 250,
                        )
                    ).toList(),
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
Future<List<String>> multiImageUpload(List<XFile> list)async{
 List<String> _path=[];
 for(XFile _image in list) {
   _path.add(await UploadImage(_image));
 }
 return _path;
}
Future<XFile?> singleImagePick()async{
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
Future<List<XFile>>multiImagePicker()async{
  List<XFile>? _images= await ImagePicker().pickMultiImage();
  if(_images!=null && _images.isNotEmpty){
    return _images;
  }
  return [];
}
Future<String> UploadImage(XFile image)async{
  Reference db=await FirebaseStorage.instance.ref("test/${getImageName(image)}");
  await db.putFile(File(image.path));
  return await db.getDownloadURL();
}
String getImageName(XFile image){
  return image.path.split("/").last;
}
