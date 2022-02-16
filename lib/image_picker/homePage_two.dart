import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/image_picker/homePage.dart';
import 'package:flutter_firebase_test/image_picker/image_picker_three.dart';

class HomePageTwo extends StatefulWidget {
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  _HomePageTwoState createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            MaterialButton(
              color: Colors.blue,
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (_)=>ImagePickerThree(ImageSourceType.gallery)));
                },
              child: Text('Image gallery',
              style: TextStyle(color: Colors.white70,fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>ImagePickerThree(ImageSourceType.camera)));
              },
              child: Text('Image Camera',
                style: TextStyle(color: Colors.white70,fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
