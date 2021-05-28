import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class AddLinkPage extends StatefulWidget {
  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> {
//  late File _image=;

  final formKey = new GlobalKey<FormState>();

  late String _myActivity;

  late String _myActivityResult;

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
//        _image = File(pickedFile.path);
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
//        _image = File(pickedFile.path);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        body: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child:
                ListView(
                    children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(EvaIcons.close,
                        size: 40.0, color: darkModeColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  'Add Community Link',
                  style: TextStyle(
                      color: isDark ? baseColor : darkModeColor,
                      fontSize: 30.0,
                      fontFamily: 'BalsamiqSans'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,top: 50),
                child: Column(

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
//                      Form(
//                        key: formKey,
//                        child: DropDownFormField(
//                          hintText: 'Group Genre',
//                          filled: false,
//                          value: _myActivity,
//                          onSaved: (value) {
//                            setState(() {
//                              _myActivity = value;
//                            });
//                          },
//                          onChanged: (value) {
//                            setState(() {
//                              _myActivity = value;
//                            });
//                          },
//                          dataSource: [
//                            {
//                              "display": "Reader's Choice",
//                              "value": "Reader's Choice",
//                            },
//                            {
//                              "display": "Tech",
//                              "value": "Tech",
//                            },
//                            {
//                              "display": "Gamers",
//                              "value": "Gamers",
//                            },
//                            {
//                              "display": "Youtube Promotion",
//                              "value": "Youtube Promotion",
//                            },
//                            {
//                              "display": "Art n Craft",
//                              "value": "Art n Craft",
//                            },
//                            {
//                              "display": "News Lovers",
//                              "value": "News Lovers",
//                            },
//                          ],
//                          textField: 'display',
//                          valueField: 'value',
//                        ),
//                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 58.0),
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/4,
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: const Offset(
                                  1.0,
                                  2.0,
                                ),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
//                            child: _image != null
////                                ? ClipRRect(
////                                    child: Image.file(
//////                                      _image,
////                                      width: 100,
////                                      height: 100,
////                                      fit: BoxFit.fill,
////                                    ),
////                                  )
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                      ),


                                    ])),
                        ),



                ),
              ),
                    SizedBox(height: 50,),
                    FlatButton(
                      color: Colors.indigoAccent,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        _saveForm();
                        Navigator.pop(context);
                      },
                    ),
            ]
                )
              )])
        ));
  }
}
