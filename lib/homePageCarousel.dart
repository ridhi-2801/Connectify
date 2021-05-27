import 'package:flutter/material.dart';
import 'LinkCards.dart';

class HomePageCarousel extends StatelessWidget {
  final title;
  final listLinkData;

  HomePageCarousel({required this.title, required this.listLinkData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Gilroy'),
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listLinkData.length,
                itemBuilder: (context, index) {
                  return new LinkCards(
                    linkText: listLinkData[index].link,
                    groupNameText: listLinkData[index].name,
                    groupImage: listLinkData[index].image,
                  );
                }),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
}