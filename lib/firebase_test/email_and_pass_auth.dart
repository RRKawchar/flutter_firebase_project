import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/firebase_test/collection_auth.dart';

class EmailAndPassAuth extends StatefulWidget {
  const EmailAndPassAuth({Key? key}) : super(key: key);

  @override
  _EmailAndPassAuthState createState() => _EmailAndPassAuthState();
}

class _EmailAndPassAuthState extends State<EmailAndPassAuth> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passController=TextEditingController();

  signUp()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text
    );
  }

  @override
  Widget build(BuildContext context) {

    User? user=FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth user(Logged ' + (user==null? 'Out' : 'In') +')'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
              ),
              TextField(
                controller: _passController,
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: (){

                       setState(() {
                         signUp();


                       });
                      },
                      child: Text("Sign Up")
                  ),
                  ElevatedButton(
                      onPressed: ()async{
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passController.text
                        );
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_)=>CollectionAuth()));

                        });

                      },
                      child: Text("Sign In")
                  ),
                  ElevatedButton(
                      onPressed: ()async{
                        await FirebaseAuth.instance.signOut();
                        setState(() {

                        });
                      },
                      child: Text("Log out")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
