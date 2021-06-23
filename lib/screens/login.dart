import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Authentication.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/Register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/googleAuth.dart';

bool isSee = true;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController _email = new TextEditingController();
TextEditingController _password = new TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 10,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Image(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Connectify",
                    style: TextStyle(
                      color: Color(0xFF58769E),
                      fontSize: 40.0,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 16, right: 16, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Email Adress", style: textStyle),
                          ),
                          TextField(
                            controller: _email,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: "abc@example.com"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Password", style: textStyle),
                          ),
                          TextField(
                            obscureText: isSee,
                            controller: _password,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isSee = isSee ? false : true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.grey,
                                    )),
                                hintText: "Enter Password"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool isUser = await signIn(
                                  _email.toString(), _password.toString());
                              if (isUser) {
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Incorrect email/password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Center(
                              child: Card(
                                color: loginColor,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 20,
                                        left: 20),
                                    child: Text("Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black))),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contextBuilder) =>
                                              Register()));
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("OR Login with ",
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black),),
                ),
                GestureDetector(
                    onTap: () async {
                      await GoogleAuth()
                          .signInWithGoogle()
                          .then((value) {
                             FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get()
                             .then((user) => {
                               if(!user.exists){
                                 FirebaseFirestore.instance
                                     .collection('Users')
                                     .doc(FirebaseAuth.instance.currentUser!.uid)
                                     .set({
                                 'email' :  FirebaseAuth.instance.currentUser!.email,
                                 'role' : 'user',})}
                             });
                        print(value);
                        Navigator.pop(context);
                      });
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color:Colors.black54,
                                  offset: const Offset(
                                    1.5,
                                    2.5,
                                  ),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,),],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(EvaIcons.google,color: Color(0xFFEA4335),),
                                  SizedBox(width: 8.0,),
                                  Text("Google",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            )
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
