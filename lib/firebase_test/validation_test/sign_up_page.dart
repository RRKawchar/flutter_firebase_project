import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/firebase_test/validation_test/sign_in_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
    TextEditingController _email=TextEditingController();
    TextEditingController _pass=TextEditingController();
    GlobalKey<FormState> _key =GlobalKey<FormState>();

   String? emailValidate(String? emailForm){
     if(emailForm==null || emailForm.isEmpty)
       return "Email address required";

       return null;
    }
    String? passValidate(String? passForm){
     if(passForm==null || passForm.isEmpty)
       return "Enter Password required";
     return null;
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.indigo,
          body: Form(
            key: _key,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Welcome Sign Up Screen!",
                                    style: TextStyle(
                                        fontSize: 22
                                    ),
                                  ),
                                  Text(
                                    "Sign Up Here",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFBBBBBB),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                        height: 48,
                                        width: 41,
                                        decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                          child: Icon(
                                            Icons.email_outlined,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),

                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                             controller: _email,
                                            validator: emailValidate,
                                            decoration: InputDecoration(
                                              hintText: "Enter your Email",
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF414041),

                                              ),
                                              labelText: 'EMAIL',
                                              labelStyle: TextStyle(
                                                fontSize: 15,

                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 48,
                                        width: 41,
                                        decoration: BoxDecoration(

                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                          child: Icon(Icons.lock_outline,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),
                                        ),

                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            controller: _pass,
                                            validator: passValidate,
                                            decoration: InputDecoration(
                                                hintText: "Enter your password",
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF414041),
                                                ),
                                                labelText: 'Password',
                                                labelStyle: TextStyle(
                                                  fontSize: 15,

                                                ),


                                            ),

                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                 Center(
                                   child: ElevatedButton(onPressed: ()async{
                                     if(_key.currentState!.validate()){

                                       try {
                                         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                             email: _email.text,
                                             password: _pass.text
                                         );
                                         var authCredential=userCredential.user;
                                         print(authCredential!.uid);
                                         if(authCredential.uid.isNotEmpty){
                                           Navigator.push(context,MaterialPageRoute(builder:(_)=>SignInPage()));
                                         }

                                       } on FirebaseAuthException catch (e) {
                                         if (e.code == 'weak-password') {
                                           Fluttertoast.showToast(msg: "The password provided is too weak.");

                                         } else if (e.code == 'email-already-in-use') {
                                           Fluttertoast.showToast(msg: "The account already exists for that email.");

                                         }
                                       } catch (e) {
                                         print(e);
                                       }
                                     }



                                   },
                                       child: Text("Sing Up")
                                   ),
                                 ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        "Already have an account?",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFBBBBBB),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          " Sign In",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,

                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInPage()));

                                        },
                                      )
                                    ],
                                  )

                                ],
                              ),

                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),

            ),
          ),
        )
    );
  }
}
