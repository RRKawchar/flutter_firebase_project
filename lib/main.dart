import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/SignIn_with_google/login_page.dart';
import 'package:flutter_firebase_test/login_with_facebook/facebook_login.dart';





 Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(myApp());
}
class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: FacebookLogin(),
    );
  }
}

