import 'dart:ui';
import 'addLinkPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Authentication.dart';
import 'package:flutter_app/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isSee=true;



    TextEditingController _emailField = new TextEditingController();
    TextEditingController _passwordField = new TextEditingController();

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
                            controller: _emailField,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: "abc@example.com"
                            ),
                          ),
                          SizedBox(height: 30,),
                          Text("Password",style: textStyle),
                          TextField(
                            controller: _passwordField,
                            obscureText: isSee,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:IconButton(
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
                          Text("Confirm Password",style: textStyle),
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
                                hintText: "Confirm Password"

                            ),
                              obscureText: isSee,

                            ),

                          SizedBox(height: 20,),

                          GestureDetector(onTap: ()async{
                            bool shouldNavigate = await register(_emailField.toString(), _passwordField.toString());
                            if(shouldNavigate==true){
                              Navigator.push(context, MaterialPageRoute(builder: (contextBuilder)=>AddLinkPage()));
                            }else{
                                 print("weak password");
                            }

                            }, child: Center(
                            child: Card(

                              color: loginColor,
                              child: Padding(
                                  padding: const EdgeInsets.only(top:10,bottom:10,right: 20,left: 20),
                                  child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white))
                              ),
                            ),
                          ),
                          ),
                          SizedBox(height: 8),

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
