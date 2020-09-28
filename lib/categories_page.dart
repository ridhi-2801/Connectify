import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/rendering.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
//      decoration: BoxDecoration(gradient: LinearGradient(
//        colors: [
//          Color(0xffFC354C),
//          Color(0xFF0ABFBC),
//        ]
//      )),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0),
              child: IconButton(icon: Icon(EvaIcons.arrowIosBack,size: 40.0,), onPressed: (){Navigator.pop(context);}, ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20.0),
              child: Text(
                "Categories",style: TextStyle(color: Colors.black,fontSize: 40.0, fontFamily: 'BalsamiqSans'),
              ),
            ),
            SizedBox(height: 15.0,),
            Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoriesCard(category: 'Tech',categoryIcon: EvaIcons.smartphoneOutline,),
                      CategoriesCard(category: 'Fashion',categoryIcon: EvaIcons.shoppingBagOutline,),
                      CategoriesCard(category: 'Photography',categoryIcon: EvaIcons.cameraOutline,),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoriesCard(category: 'Google',categoryIcon: EvaIcons.google,),
                      CategoriesCard(category: 'Github',categoryIcon: EvaIcons.githubOutline,),
                      CategoriesCard(category: 'Linkedin',categoryIcon: EvaIcons.linkedinOutline,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Explore More',style: TextStyle(color: Colors.lightBlue),),
                        Icon(EvaIcons.arrowForwardOutline,color: Colors.lightBlue,),
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    ));
  }
}

class CategoriesCard extends StatelessWidget {

  final categoryIcon;
  final category;
  CategoriesCard({
    this.category,
    this.categoryIcon,
  });

  final Color baseColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery. of(context). size. width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: baseColor,
          ),
          child: Center(
            child: ClayContainer(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categoryIcon,size: y/13,
                    ),
                    SizedBox(height: 4.0,),
                    Text(category),
                  ],
                ),
              ),
              color: baseColor,
              borderRadius: 15,
              depth: 35,
              spread: 6,
              width: y/4,
              height: y/4,
            ),
          ),
        ),
      ),
    );
  }
}
