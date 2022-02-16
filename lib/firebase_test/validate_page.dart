import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/firebase_test/collection_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ValidatePage extends StatefulWidget {
  const ValidatePage({Key? key}) : super(key: key);

  @override
  _ValidatePageState createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passController=TextEditingController();

  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  String errorMessage='';
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Validate user(Logged ' +(user==null? 'Out' : 'In')+')'),),
        body: Form(
          key: _key,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(

                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: validateEmail,
                  ),

                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    validator: validatePass,
                  ),
                  Center(
                    child: Text(errorMessage),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                      child:_isLoading?CircularProgressIndicator(color: Colors.white,):
                      Text('Sign Up'),
                        onPressed:user!=null ? null: ()async{
                        setState(() {
                          _isLoading=true;
                        });
                        if(_key.currentState!.validate()) {
                          try {
                            UserCredential userCredential= await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passController.text
                            );



                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {

                              Fluttertoast.showToast(msg: 'The password provided is too weak.');

                            } else if (e.code == 'email-already-in-use') {

                              Fluttertoast.showToast(msg: "The account already exists for that email.");

                            }
                          } catch (e) {
                            print(e);
                          }

                          setState(() {

                            _isLoading=false;

                          });
                        }

                      },
                         ),
                      ElevatedButton(onPressed: user!=null ? null:(){
                        setState(() {
                          singIn();

                        });

                      },
                          child: Text('Sign In')),
                      ElevatedButton(onPressed: user==null ? null:()async{

                        await FirebaseAuth.instance.signOut();
                        setState(() {

                        });
                      },
                          child: Text('Log out')),
                    ],
                  )
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
  singIn()async{
    if(_key.currentState!.validate()){
      try {
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passController.text
        );
        var authCredential=userCredential.user;
        print(authCredential!.uid);
        if(authCredential.uid.isNotEmpty){
          Navigator.push(context,
              MaterialPageRoute(builder: (_)=>CollectionAuth()));
        }
        else{
          Fluttertoast.showToast(msg: 'Something is wrong');
        }
        errorMessage='';
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorMessage=e.message!;
          Fluttertoast.showToast(msg: "No user found for that email.");
          print('');
        } else if (e.code == 'wrong-password') {
          errorMessage=e.message!;
          Fluttertoast.showToast(msg: 'Wrong password provided for that user.');

        }
      }
    }


  }
}
String? validateEmail(String? fromEmail){
  if(fromEmail==null || fromEmail.isEmpty)
  return 'Email address is required.';

  String pattern=r'\w+@\w+\.\w+';
  RegExp regExp=RegExp(pattern);
  if(!regExp.hasMatch(fromEmail))
    return 'Invalid Email Address Format.';
    return null;
}
String? validatePass(String? formPassword){
  if(formPassword==null || formPassword.isEmpty)
    return 'Password is required';

    String  pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
   if(!regExp.hasMatch(formPassword))
      return 'Password must be at least 8 character,\n'
          'include uppercase letter ,number and symbol';
  return null;
}


