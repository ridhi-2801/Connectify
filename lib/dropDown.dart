import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  final listCategories;
  const DropDown({Key? key, this.listCategories }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDown();
}

class _DropDown extends State<DropDown> {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  String dropDownValue = 'Select Categories';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.listCategories[0],
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
          dropDownValue = newValue!;
        });
      },
      items: widget.listCategories.map<DropdownMenuItem<String>>((document) {
        return DropdownMenuItem<String>(
          value: document,
          child: Text(document),);
      }).toList(),
    );
  }
}