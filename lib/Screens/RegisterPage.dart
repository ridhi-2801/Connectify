import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddLinkPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AuthService/Authentication.dart';
import '../Constants/constants.dart';

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
        backgroundColor:baseColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height/10,),
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
                            controller: _emailField,
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
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text("Confirm Password",style: textStyle),
                          ),
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
                            bool shouldNavigate = await register(_emailField.text.toString().trim(), _passwordField.text.toString().trim());
                            if(shouldNavigate==true){
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName("/HomePage"));
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Weak Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }

                            }, child: Center(
                            child: Card(

                              color: loginColor,
                              child: Padding(
                                  padding: const EdgeInsets.only(top:10,bottom:10,right: 20,left: 20),
                                  child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black))
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
