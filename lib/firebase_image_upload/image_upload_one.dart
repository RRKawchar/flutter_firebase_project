import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageUploadOne extends StatefulWidget {
  const ImageUploadOne({Key? key}) : super(key: key);

  @override
  _ImageUploadOneState createState() => _ImageUploadOneState();
}

class _ImageUploadOneState extends State<ImageUploadOne> {
  static final String _title='Cloud storage';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: ()async{
                    final result=await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      allowedExtensions: ['png','jpg'],
                      type: FileType.custom
                    );
                    if(result==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("No file selected"))
                      );
                      return null;
                    }
                   final _path=result.files.single.path!;
                   final fileName=result.files.single.name;
                    print(_path);
                    print(fileName);

                  },
                  child: Text("Upload file")
              ),
            )
          ],
        )
      ),
    );
  }
}
