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

  Future<List<LinkCards>> generateList(List<dynamic> listLinksDataId) async{
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    print("Link data ids : $listLinksDataId");
    List<LinkCards> listCards = [];

    listLinksDataId.forEach((linkDataId) async{
      await fireStore.collection('LinksData').doc(linkDataId).get().then((value) => listCards.add(
          LinkCards(
            link: value.get('link'),
            linkTitle: value.get('title'),
            linkImage: value.get('image'),
            relatedCategories: value.get('categories'),
            platform: value.get('platform'),
          )
          ));
    });

    return listCards;
  }

//  List<LinkData> list = [
//    LinkData(name: 'Pepcoding' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//    LinkData(name: 'PrepInsta' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//    LinkData(name: 'Coding Ninja' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//    LinkData(name: 'Pepcoding' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//    LinkData(name: 'PrepInsta' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//    LinkData(name: 'Coding Ninja' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark?darkModeColor:baseColor,
      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0),
              child: IconButton(icon: Icon(EvaIcons.arrowIosBack,size: 40.0,color:isDark?baseColor:darkModeColor), onPressed: (){Navigator.pop(context);}, ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20.0),
              child: Text(
                widget.categoryName,style: TextStyle(  color: isDark?baseColor:darkModeColor,fontSize: 40.0, fontFamily: 'BalsamiqSans'),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<LinkCards>>(
                future: generateList(widget.linksDataIds),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text('Oops! Some Error Occured!'));
                  }else{
                    if(!snapshot.hasData){
                        return Center(child: Text("Loading..."));
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        }
                    );
                  }
                },)
            ),
          ],
        ),
      )
    );
  }
}

