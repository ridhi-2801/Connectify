import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/HomePage/ExplorePage.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool error = false;
  Future loadContents() async{
    try{
      final listCategories = await FirebaseFirestore.instance.
      collection('Categories').where('onHomePage', isEqualTo: true).get();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          Explore(categoriesList: listCategories,)));
    }catch(e){
      error = true;
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    loadContents();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image(
                image: AssetImage('assets/images/logo.png',),
              ),
            ),
            Text(
              "Connectify",
              style: TextStyle(
                color: Color(0xFF58769E),
                fontSize: 40.0,
                fontFamily: 'Gilroy',
              ),
            ),
            SizedBox(height: 10.0,),
            CircularProgressIndicator(),
            error == true ? Text('Oops Some Error Occured! Check your connection') : SizedBox(),
          ],
        ),
      ),
    );
  }
}