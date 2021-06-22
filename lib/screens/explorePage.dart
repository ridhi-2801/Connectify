import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SearchPage/searchPage.dart';
import 'package:flutter_app/categoriesCard.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/addLinkPage.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../homePageCarousel.dart';
import 'categoriesPage.dart';
import 'settingsPage.dart';
import '../SearchPage/searchPage.dart';

class Explore extends StatefulWidget {

  final categoriesList;
  Explore({this.categoriesList});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final formKey = new GlobalKey<FormState>();
  final fireStore = FirebaseFirestore.instance;
  
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
          backgroundColor: Colors.blue,
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
                          ? ''
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
            Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Explore",
                    style: TextStyle(
                        color: isDark ? baseColor : darkModeColor,
                        fontSize: 44.0,
                        fontFamily: 'BalsamiqSans'),
                  ),
                  IconButton(onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          SearchPage(
                            searchType: "Community Link",
                          ))), icon: Icon(FontAwesomeIcons.search, size: 20,))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 15),
            Expanded(
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
                          return Center(child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: LinearProgressIndicator(),
                          ));
                        }
                        final linksData = snapshot.data!.docs;
                        return HomePageCarousel(
                            title: 'Hot & Trending', listLinkData: linksData);
                      }
                    },
                  ),
// //                    Container(
// //                      child: ListView.builder(
// //                        physics: NeverScrollableScrollPhysics(),
// //                          shrinkWrap: true,
// //                          itemCount: widget.categoriesList.docs.length,
// //                          itemBuilder: (context, index) {
// //                            return StreamBuilder<QuerySnapshot>(
// //                                stream: FirebaseFirestore.instance
// //                                    .collection('LinksData')
// //                                    .where('categories',
// //                                        arrayContains: widget.categoriesList.docs[index].get('title'))
// //                                    .snapshots()
// //                                    .take(6),
// //                                builder: (context, snapshot) {
// //                                  if (snapshot.hasError) {
// //                                    return Center(child: Text('${snapshot.error}'));
// //                                  } else {
// //                                    if (!snapshot.hasData) {
// //                                      return Center(
// //                                          child: Padding(
// //                                            padding: const EdgeInsets.all(30.0),
// //                                            child: CircularProgressIndicator(),
// //                                          ));
// //                                    }
// //                                    final linksData = snapshot.data!.docs;
// //                                    if(linksData.length == 0) {
// //                                      return SizedBox();
// //                                    }
// //                                    return HomePageCarousel(
// //                                        title: widget.categoriesList.docs[index].get('title'),
// //                                        listLinkData: linksData);
// //                                  }
// //                                });
// //                          }),
// //                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}