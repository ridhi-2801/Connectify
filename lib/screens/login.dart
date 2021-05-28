import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/Register.dart';

bool isSee=false;

void seePassword(){
  if(isSee==false){
    isSee=true;

  }else{
    isSee = false;
  }
}
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

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
                        Text("Email Adress",style: textStyle),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "abc@example.com"
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Password",style: textStyle),
                        TextField(
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
                          obscureText: isSee,

                        ),
                        SizedBox(height: 30,),
                        Center(child: GestureDetector(
                            onTap: (){},
                            child: Text("Forgot Password",style: TextStyle(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w500),))),
                        SizedBox(height: 10),
                        GestureDetector(onTap: (){}, child: Center(
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
                                onTap: (){

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
