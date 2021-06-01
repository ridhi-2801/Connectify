import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LinkCards.dart';
import 'package:flutter_app/constants.dart';

class CategoryPage extends StatefulWidget {
  final categoryName;
  final linksDataIds;

  CategoryPage({required this.categoryName, required this.linksDataIds});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

//  Future<List<String>> generateList(List<String> listLinksDataId) async {
//    List<String> listCards = [];
//    final collection = FirebaseFirestore.instance.collection('LinksData');
//
//    for (String docId in listLinksDataId) {
//      final snapshot = await collection.doc(docId).get();
//
//      // snapshot is the document snapshot whose id
//      // matches the index in the list you're passing in
//
//      final linksData = snapshot['linksData']; // list of ids in linksData field
//
//      for (var i = 0; i < linksData.length; i++) { // looping through list
//        final field = linksData[i];
//        listCards.add(field);
//      }
//    }
//    return listCards;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDark ? darkModeColor : baseColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8.0),
                child: IconButton(
                  icon: Icon(EvaIcons.arrowIosBack,
                      size: 40.0, color: isDark ? baseColor : darkModeColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  widget.categoryName,
                  style: TextStyle(
                      color: isDark ? baseColor : darkModeColor,
                      fontSize: 40.0,
                      fontFamily: 'BalsamiqSans'),
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('LinksData')
                    .where('categories', arrayContains: widget.categoryName)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.data!.docs.length == 0){
                      return Center(child: Text('No Links to Display',style: TextStyle(fontSize: 25.0,),),);
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return LinkCards(
                              linkImage: snapshot.data!.docs[index].get('image'),
                              linkTitle: snapshot.data!.docs[index].get('name'),
                              link: snapshot.data!.docs[index].get('link'),
                              relatedCategories: snapshot.data!.docs[index].get('categories'),
                              platform: snapshot.data!.docs[index].get('platform'));
                        });
                  }
                },
              )),
            ],
          ),
        ));
  }
}
