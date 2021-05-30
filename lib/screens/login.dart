import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Authentication.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/Register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'addLinkPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app/googleAuth.dart';
bool isSee=true;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController _email = new TextEditingController();
TextEditingController _password  = new TextEditingController();

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: loginColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height/10,),
                Center(
                  child: Icon(
                   Icons.people,

                    size: 50,
                    color: Colors.orange,
                  ),
                ),
                Center(
                  child: Text(
                    "Connectify",style: TextStyle(  color: Colors.orange,fontSize: 40.0, fontFamily: 'BalsamiqSans',),
                  ),
                ),
              SizedBox(height: height/40,),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top:30.0,left: 16,right: 16,bottom: 15),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Email Adress",style: textStyle),
                        ),
                        TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "abc@example.com"
                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(

                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Password",style: textStyle),
                        ),
                        TextField(
                          obscureText: isSee,
                          controller: _password,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSee =
                                      isSee ? false : true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.grey,
                                  )),
                              hintText: "Enter Password"

                          ),


                        ),
                        SizedBox(height: 30,),


                        GestureDetector(onTap: ()async{
                            bool isUser = await signIn(_email.toString(), _password.toString());
                            if(isUser){
                              Navigator.push(context, MaterialPageRoute(builder: (contextBuilder)=>AddLinkPage()));
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Incorrect email/password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
//                          Navigator.push(context, MaterialPageRoute(builder: (contextBuilder)=>AddLinkPage()));
                        }, child: Center(
                          child: Card(

                              color: loginColor,
                              child: Padding(
                                padding: const EdgeInsets.only(top:10,bottom:10,right: 20,left: 20),
                                child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white))
                              ),
                          ),
                        ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (contextBuilder)=>Register()));
                            }, child: Text("REGISTER",style: TextStyle(fontSize: 16,color: loginColor,fontWeight: FontWeight.w700),)),
                            GestureDetector(
                                onTap: () async {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  await GoogleAuth().signInWithGoogle().then((value){
                                    print(value);
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AddLinkPage()));
                                  });
                                },
                                child: CircleAvatar(backgroundColor: loginColor,child: Icon(EvaIcons.google,color: baseColor,),))

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
