import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'LinkCards.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}
class _ExploreState extends State<Explore> {
  final formKey = new GlobalKey<FormState>();
  String _myActivity;
  String _myActivityResult;
  File _image;

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
        }
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff075E54),
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
         Alert(context: context,
           title: "Add a  Group",
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
                padding: const EdgeInsets.only(top:18.0),
                child: GestureDetector(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _image!=null? ClipRRect(
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ):Column(
                        children: [
                          Icon(Icons.add,size: 50,color: Colors.black54,),
                          SizedBox(height: 10,),
                          Text("Add Image",style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18
                          ),)
                        ],
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
             buttons: [
               DialogButton(
                 onPressed: () => _saveForm(),
                 color: Color(0xff075E54),
                 child: Text(
                   "Add",
                   style: TextStyle(color: Colors.white, fontSize: 20),
                 ),
               )
             ]
         ).show();
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        centerTitle: true,
        title: Text(
          "Explore",
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Color(0xff075E54),
            ),
          ),
          ListTile(
            title: Text('Rate Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 500,
          child: ListView(
            children: [
              Text(
                "Tech Groups",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    linkCards(),
                    linkCards(),
                    linkCards(),
                    linkCards(),
                  ],
                ),
              ),
              Text(
                "Reader's Choice",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    linkCards(),
                    linkCards(),
                    linkCards(),
                    linkCards()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
