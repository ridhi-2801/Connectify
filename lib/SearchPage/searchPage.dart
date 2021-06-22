import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

import 'SearchViewPage.dart';

class SearchPage extends StatefulWidget {
  final searchType;
  SearchPage({this.searchType});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchData = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController textEditingController = TextEditingController();
  String textSearch = 'some loreal epsum';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Container(
            height: 0.06 * MediaQuery.of(context).size.height,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    textEditingController.clear();
                    // Navigator.of(context).pop();
                  },
                ),
                hintText: "Search a ${widget.searchType} ...",
              ),
              // keyboardType: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  if (value == "") {
                    textSearch = "99";
                  } else {
                    textSearch = value;
                  }
                });
                print(value);
              },
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot> (
          stream: widget.searchType == "Category"
              ? firebaseFirestore.collection("Categories")
              .orderBy('lowerCaseTitle')
              .startAt([textSearch.toLowerCase()])
              .endAt([textSearch.toLowerCase() + '\uf8ff'])
              .snapshots()
              :
              firebaseFirestore.collection("LinksData")
                  .orderBy('lowerCaseName',)
                  .startAt([textSearch.toLowerCase() ,])
                  .endAt([textSearch.toLowerCase() + '\uf8ff', ])
                  .snapshots(),
            // textSearch[0].toUpperCase() + textSearch.substring(1) + '\uf8ff'

            builder: (context, snapshot) {
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError){
              return Center(child: Text(
                "Something went wrong, try again!",
                style: TextStyle(
                  fontSize:
                  0.03 * MediaQuery.of(context).size.height,
                  fontFamily: 'Poppins-SemiBold',
                  color: darkModeColor,
                ),
              ));
            }

            if(snapshot.data!.docs.length == 0){
              return Center(
                child: Text(
                  "No Groups to display!!",
                  style: TextStyle(
                    fontSize:
                    0.03 * MediaQuery.of(context).size.height,
                    fontFamily: 'Poppins-SemiBold',
                    color: darkModeColor,
                  ),
                ),
              );
            }
            final dataList = snapshot.data!.docs;
            dataList.forEach((result) {
                print(result.data());
              });

            return SearchViewScreen(
              // list: allStories,
              isCategorySearch: widget.searchType == "Category" ? true : false,
              list: dataList,
            );
          },
        ),
      ),
    );
  }
}
