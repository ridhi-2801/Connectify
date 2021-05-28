import 'package:flutter/material.dart';
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

//login page constants

final textStyle=TextStyle(fontSize: 20,fontWeight: FontWeight.w500);
final loginColor=Color(0xff744cbc);



var iconMap = {
  'Coding':EvaIcons.smartphoneOutline,
  'Fashion':EvaIcons.shoppingBagOutline,
  'Photography':EvaIcons.cameraOutline,
  'Google' :EvaIcons.google,
  'Github' :EvaIcons.githubOutline,
  'Linkedin': EvaIcons.linkedinOutline,
};