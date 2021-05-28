import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/linkData.dart';
import 'package:flutter_app/screens/addLinkPage.dart';
import 'package:image_picker/image_picker.dart';
import '../../LinkCards.dart';
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
  late String _myActivity;
  late String _myActivityResult;
  late File _image;

  final fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final picker = ImagePicker();
  _imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  List<LinkData> list = [
    LinkData(
        name: 'Pepcoding',
        categories: [],
        image: '#',
        platform: 'Telegram',
        link: '#'),
    LinkData(
        name: 'PrepInsta',
        categories: ['#'],
        image: '#',
        platform: 'Telegram',
        link: '#'),
    LinkData(
        name: 'Coding Ninja',
        categories: ['#'],
        image: '#',
        platform: 'Telegram',
        link: '#'),
  ];

  @override
  Widget build(BuildContext context) {
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
              context, MaterialPageRoute(builder: (context) => AddLinkPage())),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          size: 25.0,
                          color: isDark ? baseColor : darkModeColor),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage())),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
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
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ListView(
                    children: [
                      HomePageCarousel(
                        listLinkData: list,
                        title: "Coding",
                      ),
                      HomePageCarousel(
                        listLinkData: list,
                        title: "Technical",
                      ),
                      HomePageCarousel(
                        listLinkData: list,
                        title: "Podcast",
                      ),
                      HomePageCarousel(
                        listLinkData: list,
                        title: "Chicku <3 Panda",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardSearch extends SearchDelegate<LinkCards> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
//          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return LinkCards(
      link: "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
      linkTitle: "Flutter Dev",
      linkImage: '',
      relatedCategories: [],
      platform: '',
    );
  }
}
