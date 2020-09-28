import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'LinkCards.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'categories_page.dart';


class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final formKey = new GlobalKey<FormState>();
  String _myActivity;
  String _myActivityResult;
  File _image;
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

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add a  Group'),
                  scrollable: true,
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Name of Group',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Link of group',
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: DropDownFormField(
                          hintText: 'Group Genre',
                          filled: false,
                          value: _myActivity,
                          onSaved: (value) {
                            setState(() {
                              _myActivity = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _myActivity = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "Reader's Choice",
                              "value": "Reader's Choice",
                            },
                            {
                              "display": "Tech",
                              "value": "Tech",
                            },
                            {
                              "display": "Gamers",
                              "value": "Gamers",
                            },
                            {
                              "display": "Youtube Promotion",
                              "value": "Youtube Promotion",
                            },
                            {
                              "display": "Art n Craft",
                              "value": "Art n Craft",
                            },
                            {
                              "display": "News Lovers",
                              "value": "News Lovers",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Card(
                            elevation: 10,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: _image != null
                                    ? ClipRRect(
                                        child: Image.file(
                                          _image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Add Image",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18),
                                          )
                                        ],
                                      )),
                          ),
                        ),
                      )
                    ],
                  ),
                  actions: [
                    FlatButton(
                      color: Color(0xff075E54),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        _saveForm();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
//      appBar: AppBar(
//        elevation: 0,
//        backgroundColor: Color(0xff075E54),
//        centerTitle: true,
//        title: Text(
//          "Explore",
//        ),
//        actions: [
//          IconButton(
//              icon: Icon(
//                Icons.search,
//                color: Colors.white,
//              ),
//              onPressed: (){
//                showSearch(context: context, delegate: CardSearch());
//              })
//        ],
//      ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 8.0,),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    IconButton(icon: Icon(EvaIcons.gridOutline,size: 25.0,), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CategoriesPage();
                      }));
                    }),
                    IconButton(icon: Icon(EvaIcons.settings2Outline,size: 25.0,), onPressed: (){}),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,),
                child: Text(
                  "Explore",style: TextStyle(color: Colors.black,fontSize: 44.0, fontFamily: 'BalsamiqSans'),
                ),
              ),
              SizedBox(height: 10,),
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
              SizedBox(height:20),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(
                          "Tech Groups",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(
                          "Reader's Choice",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                            LinkCards(
                              linkText:
                                  "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                              groupNameText: "Flutter Dev",
                            ),
                          ],
                        ),
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
    IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return LinkCards(
      linkText: "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
      groupNameText: "Flutter Dev",
    );
  }
}
