import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LinkCards.dart';
import 'package:flutter_app/constants.dart';

class CategoryPage extends StatelessWidget {
  final categoryName;
  final fireStore = FirebaseFirestore.instance;
  CategoryPage({this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark?darkModeColor:baseColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark?darkModeColor:baseColor,
        title: Text(categoryName, style: TextStyle(fontFamily: 'BalsamiqSans',fontSize:30,color:isDark?baseColor:darkModeColor),),
        leading: IconButton(
          icon: Icon(EvaIcons.arrowIosBack,color:isDark?baseColor:darkModeColor),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: ListView(
          scrollDirection: Axis.vertical,
     children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             LinkCards(groupImage: "", groupNameText: "", linkText: ""),
             LinkCards(groupImage: "", groupNameText: "", linkText: ""),
           ],
         ),
     ],


        ),
      ),
    );
  }
}
