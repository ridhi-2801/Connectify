import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddLinkPage extends StatefulWidget {
  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  String categorySelected = '';
  String uploadedFileURL = '';
  File? _image;
  final picker = ImagePicker();

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<DropdownMenuItem<String>> platformDropDowns() {
    List<DropdownMenuItem<String>> items = [];
    platforms.forEach((value) {
      items.add(new DropdownMenuItem(value: value, child: Text(value)));
    });
    return items;
  }

  Future<void> uploadImage(File? img) async {
    var path = img!.path;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("${path.split("/").last}");
    UploadTask uploadTask = storageReference.putFile(img);
    await uploadTask.whenComplete(() async {
      print('File Uploaded');
      uploadedFileURL = await storageReference.getDownloadURL();
    });
  }

  Future<void> uploadLink() async {
      FirebaseFirestore.instance.collection('LinksData').add({
        'image': uploadedFileURL,
        'link': linkController.text,
        'name': groupNameController.text,
        'platform': platform,
        'lowerCaseName': groupNameController.text.toLowerCase(),
        'categories': [categorySelected]
      }).then((value) => {
            print('Link Added'),
        Fluttertoast.showToast(msg: 'Link Uploaded!',toastLength: Toast.LENGTH_LONG , backgroundColor: Colors.blue, textColor: Colors.white),
            Navigator.pop(context),
          });
  }

  String platform = platforms[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(EvaIcons.close,
                        size: 35.0, color: isDark ? baseColor : darkModeColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Community Link',
                    style: TextStyle(
                        color: isDark ? baseColor : darkModeColor,
                        fontSize: 30.0,
                        fontFamily: 'BalsamiqSans'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: groupNameController,
                    decoration: const InputDecoration(
                      hintText: 'Name of Group',
                        hintStyle: TextStyle( color: Colors.blue),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))
                    ),
                  ),
                  TextFormField(
                    controller: linkController,
                    decoration: const InputDecoration(
                      hintText: 'Link',
                        hintStyle: TextStyle( color: Colors.blue),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Select a platform",style: TextStyle(color: isDark?baseColor:darkModeColor),),
                  DropdownButton<String>(
                    hint: Text('Select a plaltform!'),
                    value: platform,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        platform = newValue!;
                      });
                    },
                    items: platformDropDowns(),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Select a category",style: TextStyle(color: isDark?baseColor:darkModeColor),),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Categories')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Oops Something Wrong browsing categories!\nAdd sometime later');
                        } else {
                          if (snapshot.hasData) {
                            final listCategories = snapshot.data!.docs;
                            categorySelected = listCategories[0].get('title') ?? 'Some Error Occurred! Check your connection';
                            return DropdownButton<String>(
                              value: categorySelected,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String? newValue){
                                print(newValue);
                                setState(() {
                                   categorySelected = newValue!;
                                });
                              },
                              items: listCategories
                                  .map<DropdownMenuItem<String>>((document) {
                                return DropdownMenuItem<String>(
                                  value: document.get('title'),
                                  child: Text(document.get('title')),
                                );
                              }).toList(),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
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
                            child: _image != null
                                ? ClipRRect(
                                    child: Image.file(
                                      _image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 20, ),
                    ),
                    onPressed: () async {
                      Fluttertoast.showToast(msg: 'Loading ...', backgroundColor: Colors.blue, textColor: Colors.white);

                      if (linkController.text.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Link Not added!'),
                        ));
                        return;
                      }

                      if (groupNameController.text.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Group Name Not Added!'),
                        ));
                        return;
                      }

                      if (platform.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Select a Platform!'),
                        ));
                        return;
                      }

                      if (categorySelected.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please select a category!'),
                        ));
                        return;
                      }

                      if(_image!= null){
                        await uploadImage(_image);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Upload an image!'),
                        ));
                      }

                      if (uploadedFileURL.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Image not uploaded!'),
                        ));
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Uploading! Please Wait!'),
                        ));
                        await uploadLink();

                    },
                  ),
                ]),
          ),
        ));
  }
}
