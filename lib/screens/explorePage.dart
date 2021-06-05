import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/categoriesCard.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/addLinkPage.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../homePageCarousel.dart';
import 'categoriesPage.dart';
import 'settingsPage.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final formKey = new GlobalKey<FormState>();
  final fireStore = FirebaseFirestore.instance;
  var categoriesData = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser ?? 'User Not Logged In';
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FirebaseAuth.instance.currentUser == null
                          ? Login()
                          : AddLinkPage())),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 8.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      FirebaseAuth.instance.currentUser == null
                          ? 'Hello Stranger...'
                          : 'Hello ${FirebaseAuth.instance.currentUser!.displayName}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MeriendaOne'),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(EvaIcons.gridOutline,
                          size: 25.0,
                          color: isDark ? baseColor : darkModeColor),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoriesPage();
                        }));
                      }),
                  IconButton(
                    icon: Icon(EvaIcons.settings2Outline,
                        size: 25.0, color: isDark ? baseColor : darkModeColor),
                    onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()))
                        .then((value) => setState(() {})),
                  ),
                ],
              ),
            ),
            FirebaseAuth.instance.currentUser == null
                ? Padding(
                    padding: const EdgeInsets.only(left: 25.0, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()))
                            .then((value) => setState(() {}));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.14,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              offset: const Offset(
                                2.0,
                                2.0,
                              ),
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                            ), //BoxShadow
                          ]),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                  color: Colors.blue,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ))),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
              ),
              child: Text(
                "Explore",
                style: TextStyle(
                    color: isDark ? baseColor : darkModeColor,
                    fontSize: 44.0,
                    fontFamily: 'BalsamiqSans'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
            SizedBox(height: 15),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                          color: isDark ? baseColor : darkModeColor,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Categories')
                              .where('onHomePage', isEqualTo: true)
                              .snapshots()
                              .take(10),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('${snapshot.error}'));
                            } else {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              final categoryData = snapshot.data!.docs;
                              categoriesData = categoryData;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: categoryData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return CategoriesCard(
                                      sizeRatio: 5,
                                      borderRadius: 60,
                                      categoryIcon: iconMap[
                                          categoryData[index].get('icon')],
                                      categoryName:
                                          categoryData[index].get('title'),
                                      linksDataIds:
                                          categoryData[index].get('linksData'),
                                    );
                                  });
                            }
                          }),
                    ),
                    SizedBox(height: 6.0,),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('LinksData')
                          .where('categories', arrayContains: 'Trending')
                          .snapshots()
                          .take(10),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final linksData = snapshot.data!.docs;
                          return HomePageCarousel(
                              title: 'Hot & Trending', listLinkData: linksData);
                        }
                      },
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoriesData.length,
                          itemBuilder: (context, index) {
                            return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('LinksData')
                                    .where('categories',
                                        arrayContains: categoriesData[index].get('title'))
                                    .snapshots()
                                    .take(6),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text('${snapshot.error}'));
                                  } else {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final linksData = snapshot.data!.docs;
                                    if(linksData.length == 0) {
                                      return SizedBox();
                                    }
                                    return HomePageCarousel(
                                        title: categoriesData[index].get('title'),
                                        listLinkData: linksData);
                                  }
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}