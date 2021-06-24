import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

final Color baseColor = Colors.white;
final Color darkModeColor = Colors.black;
bool isDark=false;

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class LinkData {
  LinkData({
    this.name,
    this.categories,
    this.image,
    this.platform,
    this.link,
  });

  final link;
  final name;
  final categories;
  final image;
  final platform;
}

class CategoryData {
  CategoryData({
    this.title,
    this.icon,
    this.linksData,
    this.onHomePage,
  });

  final title;
  final icon;
  final linksData;
  final onHomePage;
}



//login page constants
final textStyle=TextStyle(fontSize: 20,fontWeight: FontWeight.w500);
final loginColor=baseColor;

Map<String,IconData> iconMap = {
  'Coding':EvaIcons.smartphoneOutline,
  'Fashion':EvaIcons.shoppingBagOutline,
  'Photography':EvaIcons.cameraOutline,
  'Google' :EvaIcons.google,
  'Github' :EvaIcons.githubOutline,
  'Linkedin': EvaIcons.linkedinOutline,
  'Hot and Trending':FontAwesomeIcons.hotjar,
  'Youtube Promotion':FontAwesomeIcons.youtube,
  'Job Hirings':FontAwesomeIcons.hireAHelper,
  'Tours n Travels': FontAwesomeIcons.car,
  'Public Health Care':FontAwesomeIcons.disease,
  'Women safety': FontAwesomeIcons.female,
  'Buying and selling': FontAwesomeIcons.buysellads,
  'Trading':FontAwesomeIcons.bitcoin,
  'Stocks':FontAwesomeIcons.building,
  'Art & craft': FontAwesomeIcons.paintBrush,
  'Promotion': FontAwesomeIcons.teamspeak,
  'NGOs': FontAwesomeIcons.handsHelping,
  'Others' : FontAwesomeIcons.users,
};

Map<String,IconData> platformIconMap = {
  'Telegram' : FontAwesomeIcons.telegram,
  'Whatsapp' : FontAwesomeIcons.whatsapp,
  'Facebook' : FontAwesomeIcons.facebookSquare,
  'Discord' : FontAwesomeIcons.discord,
  'Reddit' : FontAwesomeIcons.reddit,
};

List<String> platforms = ['Telegram','Whatsapp','Facebook', 'Discord' ,'Reddit'];