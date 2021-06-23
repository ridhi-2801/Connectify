import 'package:flutter/material.dart';
import 'package:flutter_app/Cards/LinkCards.dart';
import 'package:flutter_app/Constants/constants.dart';

class HomePageCarousel extends StatelessWidget {
  final title;
  final listLinkData;

  HomePageCarousel({required this.title, required this.listLinkData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,bottom: 5.0),
      child: Container(
        width: double.infinity,
        height: 250,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Gilroy',
                  color: isDark ? baseColor :darkModeColor,),
                ),
              ),
            ),
            Flexible(
            flex: 5,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listLinkData.length,
                  itemBuilder: (context, index) {
                    return new LinkCards(
                      link: listLinkData[index].get('link'),
                      linkTitle: listLinkData[index].get('name'),
                      linkImage: listLinkData[index].get('image'),
                      platform: listLinkData[index].get('platform'),
                      relatedCategories: listLinkData[index].get('categories'),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}