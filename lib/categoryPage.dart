import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LinkCards.dart';
import 'package:flutter_app/constants.dart';
import 'linkData.dart';

class CategoryPage extends StatelessWidget {
  final categoryName;
  final linksDataIds;
  
  CategoryPage({this.categoryName, this.linksDataIds});
  
  Future<void> generateList(List<String> listLinksDataId) async{
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    List<DocumentSnapshot> list = [];

    listLinksDataId.forEach((linkDataId) async{
      DocumentSnapshot document = await fireStore.collection('LinksData').doc(linkDataId).get();
      list.add(document);
    });

    try{

      final listLinksData = list.map((snapshot) => LinkCards(
        link: snapshot.get('link'),
        linkTitle: snapshot.get('title'),
        linkImage: snapshot.get('image'),
        relatedCategories: snapshot.get('categories'),
        platform: snapshot.get('platform'),
      ));

    }catch(e){
      print(e);
    }

  }

  List<LinkData> list = [
    LinkData(name: 'Pepcoding' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
    LinkData(name: 'PrepInsta' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
    LinkData(name: 'Coding Ninja' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
    LinkData(name: 'Pepcoding' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
    LinkData(name: 'PrepInsta' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
    LinkData(name: 'Coding Ninja' , categories: ['#'] , image: '#' , platform: 'Telegram', link: '#' ),
  ];

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
                categoryName,style: TextStyle(  color: isDark?baseColor:darkModeColor,fontSize: 40.0, fontFamily: 'BalsamiqSans'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: generateList(linksDataIds),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text('Oops! Some Error Occured!'));
                  }else{
                    if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return new LinkCards(
                            link: list[index].link,
                            linkTitle: list[index].name,
                            linkImage: list[index].image,
                            platform: list[index].platform,
                            relatedCategories: list[index].categories,
                          );}
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

