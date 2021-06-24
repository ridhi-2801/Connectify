import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AddLinkPage.dart';
import '../SearchPage/searchPage.dart';
import '../../Cards/categoriesCard.dart';
import '../../Constants/constants.dart';
import 'package:flutter_app/screens/LoginPage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../HomePage/homePageCarousel.dart';
import '../CategoriesPage/categoriesPage.dart';
import '../SettingsPage.dart';

bool isAdmin = false;

class Explore extends StatefulWidget {
  final categoriesList;
  Explore({this.categoriesList});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final formKey = new GlobalKey<FormState>();
  final fireStore = FirebaseFirestore.instance;

  Future<void> checkAdmin() async{
    if(FirebaseAuth.instance.currentUser != null){
      print(FirebaseAuth.instance.currentUser);
      await FirebaseFirestore.instance.collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) => {
            print(FirebaseAuth.instance.currentUser!.uid),
        if(snapshot.exists && snapshot.get('role') == 'admin'){
          isAdmin = true,
          print('User is Admin!'),
        }else{
          print('User not Admin!'),
        }
      });
    }else{
      print('User Not Logged In');
    }
  }

  @override
  void initState() {
    super.initState();
    checkAdmin();
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
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "/HomePage"),
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
                          :   "Hello ${FirebaseAuth.instance.currentUser!.displayName
                              ??
                              FirebaseAuth.instance.currentUser!.email!.split('@')[0] ?? '!!'}",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MeriendaOne'),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(isDark ? EvaIcons.sun : FontAwesomeIcons.moon,
                          size: 25.0,
                          color: isDark ? baseColor : darkModeColor),
                      onPressed: () {
                        if(isDark==false) {
                          isDark=true;
                        }else{
                          isDark=false;
                        }
                        setState(() {});}
                  ),
                  IconButton(
                    icon: Icon(EvaIcons.settings2Outline,
                    size: 25.0, color: isDark ? baseColor : darkModeColor),
                    onPressed: () {
                      Navigator.push(
                      context,MaterialPageRoute(
                          settings: RouteSettings(name: "/HomePage"),
                          builder: (context) => SettingsPage()))
                            .then((value) => setState(() {}));},
                      ),
                  ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
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
                  Spacer(),
                  IconButton(
                      icon: Icon(EvaIcons.gridOutline,
                          size: 25.0,
                          color: isDark ? baseColor : darkModeColor),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                settings: RouteSettings(name: "/HomePage"),
                                builder: (context) {
                              return CategoriesPage();
                            }));
                      }),
                  IconButton(onPressed: () => Navigator.push(context,
                      MaterialPageRoute(
                          settings: RouteSettings(name: "/HomePage"),
                          builder: (context) =>
                          SearchPage(
                            searchType: "Community Link",
                          ))), icon: Icon(FontAwesomeIcons.search, color : isDark ? baseColor : darkModeColor,size: 20,)),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
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
                                      sizeRatio: 4.5,
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
                    SizedBox(height: 15.0,),
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
                    Image(image: AssetImage("assets/images/contribute.png")),
                    SizedBox(height: 25,),
                    Container(
                     child: ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: widget.categoriesList.docs.length,
                         itemBuilder: (context, index) {
                           return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('LinksData')
                                      .where('categories',
                                      arrayContains: widget.categoriesList.docs[index].get('title'))
                                      .limit(8)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(child: Text('${snapshot.error}'));
                                    } else {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(30.0),
                                              child: CircularProgressIndicator(),
                                            ));
                                      }
                                      final linksData = snapshot.data!.docs;
                                      if(linksData.length == 0) {
                                        return SizedBox();
                                      }
                                      return HomePageCarousel(
                                          title: widget.categoriesList.docs[index].get('title'),
                                          listLinkData: linksData);
                                    }
                                  });
                            }),
                      ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: darkModeColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(
                              2.0,
                              2.0,
                            ),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 3,),
                            SizedBox(
                              width: width/1.5,
                              child:  Text("Keep your sensitive information private "
                                  "before entering public groups !!",
                                style: TextStyle(color: baseColor,
                                    fontWeight: FontWeight.bold,fontSize: 18,
                                    fontFamily: 'BalsamiqSans'),),
                            ),
                            Image(image: AssetImage("assets/images/crime.jpg"),)
                          ],
                      )
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