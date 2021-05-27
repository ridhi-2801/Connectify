import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final categoryName;

  CategoryPage({this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(categoryName, style: TextStyle(fontFamily: 'BalsamiqSans'),),
        leading: IconButton(
          icon: Icon(EvaIcons.arrowIosBack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(

      ),
    );
  }
}
