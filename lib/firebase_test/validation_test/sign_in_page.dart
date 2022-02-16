import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/firebase_test/validation_test/collection_page.dart';
import 'package:flutter_firebase_test/firebase_test/validation_test/collection_page_two.dart';
import 'package:flutter_firebase_test/firebase_test/validation_test/sign_up_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();

  GlobalKey<FormState> _key=GlobalKey<FormState>();

  Future signIn()async{
    if(_key.currentState!.validate()){
      try {
        UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text,
            password: _pass.text
        );
        var authCredential=userCredential.user;
        if(authCredential!.uid.isNotEmpty){
          Navigator.push(context,MaterialPageRoute(
              builder: (_)=>CollectionPageTwo()));
        }else{
          Fluttertoast.showToast(msg: "Something is wrong");
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {

          Fluttertoast.showToast(msg: "No user found for that email.");

        } else if (e.code == 'wrong-password') {

          Fluttertoast.showToast(msg: "Wrong password provided for that user.");

        }
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _key,
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  Text("Welcome to Sign in Screen!",
                  style: TextStyle(fontSize: 20.0,color: Colors.white),
                  ),
                  Text("Log in Here!" ,
                    style: TextStyle(color: Colors.white),),
                  SizedBox(height: 40,),
                  Container(
                    height: 600,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,


                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _email,
                           validator: emailValidate,
                           decoration: InputDecoration(
                             hintText: "Enter your email",
                             label: Text("Email"),

                             border: OutlineInputBorder(
                               borderSide: BorderSide(width: 2,color: Colors.indigo),
                               borderRadius: BorderRadius.circular(20.0)
                             ),

                           ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _pass,
                            validator: passValidate,
                            decoration: InputDecoration(
                              hintText: "Enter your Password",
                              label: Text("Password"),

                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.indigo),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),

                            ),
                          ),
                         SizedBox(height: 20.0,),
                         Container(
                           height: 40.0,
                           width:200 ,
                           decoration: BoxDecoration(
                             color: Colors.indigo
                           ),
                           child:OutlinedButton(

                               onPressed: (){
                                 setState(() {
                                   signIn();
                                 });



                           },
                               child: Text('Log In',
                               style: TextStyle(color: Colors.white,fontSize: 30.0),)
                           ),
                         ),
                         SizedBox(height: 20.0,),
                         GestureDetector(
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                             // crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text("Don't have an account? "),
                               Text("Sign Up"
                               ,
                               style: TextStyle(fontSize: 20.0,color: Colors.indigo,fontWeight: FontWeight.bold),)
                             ],
                           ),
                           onTap: (){
                             setState(() {
                               Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                             });

                           },
                         )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  String? emailValidate(String? emailForm){
    if(emailForm==null || emailForm.isEmpty)
      return "email address is required";
  }
  String? passValidate(String? passForm){
    if(passForm==null || passForm.isEmpty)
      return "password is requried";
  }

}
