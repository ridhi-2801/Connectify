import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/rendering.dart';
import '../category_page.dart';
import '../constants.dart';

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
        backgroundColor:isDark?darkModeColor:baseColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0),
              child: IconButton(icon: Icon(EvaIcons.arrowIosBack,size: 40.0,color:isDark?baseColor:darkModeColor), onPressed: (){Navigator.pop(context);}, ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20.0),
              child: Text(
                "Categories",style: TextStyle(  color: isDark?baseColor:darkModeColor,fontSize: 40.0, fontFamily: 'BalsamiqSans'),
              ),
            ),
            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.withOpacity(0.1)
                ),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(EvaIcons.searchOutline,size: 25.0,color: Color(0xFF6486B2),),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xFF6486B2)),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesCard(categoryName: 'Tech',categoryIcon: EvaIcons.smartphoneOutline,),
                          CategoriesCard(categoryName: 'Fashion',categoryIcon: EvaIcons.shoppingBagOutline,),
                          CategoriesCard(categoryName: 'Photography',categoryIcon: EvaIcons.cameraOutline,),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesCard(categoryName: 'Google',categoryIcon: EvaIcons.google,),
                          CategoriesCard(categoryName: 'Github',categoryIcon: EvaIcons.githubOutline,),
                          CategoriesCard(categoryName: 'Linkedin',categoryIcon: EvaIcons.linkedinOutline,),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesCard(categoryName: 'Tech',categoryIcon: EvaIcons.smartphoneOutline,),
                          CategoriesCard(categoryName: 'Fashion',categoryIcon: EvaIcons.shoppingBagOutline,),
                          CategoriesCard(categoryName: 'Photography',categoryIcon: EvaIcons.cameraOutline,),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesCard(categoryName: 'Tech',categoryIcon: EvaIcons.smartphoneOutline,),
                          CategoriesCard(categoryName: 'Fashion',categoryIcon: EvaIcons.shoppingBagOutline,),
                          CategoriesCard(categoryName: 'Photography',categoryIcon: EvaIcons.cameraOutline,),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoriesCard(categoryName: 'Tech',categoryIcon: EvaIcons.smartphoneOutline,),
                          CategoriesCard(categoryName: 'Fashion',categoryIcon: EvaIcons.shoppingBagOutline,),
                          CategoriesCard(categoryName: 'Photography',categoryIcon: EvaIcons.cameraOutline,),
                        ],
                      ),
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CategoriesCard extends StatelessWidget {

  final categoryIcon;
  final categoryName;
  CategoriesCard({
    this.categoryName,
    this.categoryIcon,
  });



  @override
  Widget build(BuildContext context) {
    double y = MediaQuery. of(context). size. width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CategoryPage(categoryName: categoryName,);
            }
          ));
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
                      color: isDark?baseColor:darkModeColor,
                    ),
                    SizedBox(height: 4.0,),
                    Text(categoryName,style: TextStyle(  color: isDark?baseColor:darkModeColor,),),
                  ],
                ),
              ),
              color: isDark?darkModeColor:baseColor,
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
