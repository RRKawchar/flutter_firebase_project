import 'package:flutter/material.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  _FacebookLoginState createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook login'),
      ),
      body: Center(
        child: FloatingActionButton.extended(
            onPressed: (){

            },
            label: Text('Login with facebook')
        ),
      ),
    );
  }
}
