import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../categoriesCard.dart';
import '../constants.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0),
              child: IconButton(
                icon: Icon(EvaIcons.arrowIosBack,
                    size: 40.0, color: isDark ? baseColor : darkModeColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20.0),
              child: Text(
                "Categories",
                style: TextStyle(
                    color: isDark ? baseColor : darkModeColor,
                    fontSize: 40.0,
                    fontFamily: 'BalsamiqSans'),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0),
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey.withOpacity(0.1)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      EvaIcons.searchOutline,
                      size: 25.0,
                      color: Color(0xFF6486B2),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xFF6486B2)),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child:
                        Text('Oops! An Error Occured!\nCheck your connection!'),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final categoriesList = snapshot.data!.docs;


                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150),
                      itemCount: categoriesList.length,
                      itemBuilder: (context, index) {
                        final iconData = iconMap[categoriesList[index].get('icon')];

                        return CategoriesCard(
                          categoryName: categoriesList[index].get('title'),
                          categoryIcon: iconData,
                          linksDataIds: categoriesList[index].get('linksData'),
                        );
                      });
                }
              },
            )),
          ],
        ),
      ),
    ));
  }
}
