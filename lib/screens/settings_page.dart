import 'package:clay_containers/clay_containers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        child: Scaffold(
          backgroundColor: isDark?darkModeColor:Colors.white,

            body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8.0),
            child: IconButton(
              icon: Icon(
                EvaIcons.arrowIosBack,
                color:isDark?Colors.white:darkModeColor,
                size: 40.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text(
              "Settings",
              style: TextStyle(
                  color: isDark?Colors.white:darkModeColor, fontSize: 40.0, fontFamily: 'BalsamiqSans'),
            ),
          ),
          SizedBox(
            height: 25.0),
              SettingsListTitles(title: "Switch Theme", icons: EvaIcons.moon,tap: (){
               setState(() {
                 if(isDark==false) {
                   isDark=true;

                 }else{
                   isDark=false;
                 }
               });
              },),

              Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: SettingsListTitles(title: "Rate and Review", icons: EvaIcons.star, tap: (){
                  launchURL("");
                },),
              ),

              Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: SettingsListTitles(title: "About", icons: EvaIcons.people, tap: (){},),
              ),

              Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: SettingsListTitles(title: "Admin Area", icons: EvaIcons.people, tap: (){},),
              ),
        ])),
      ),
    );
  }
}

class SettingsListTitles extends StatelessWidget {

 final String title;
 final IconData icons;
 final  tap;

 SettingsListTitles({required this.title,required this.icons,required this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:  baseColor
        ),
        child: ClayContainer(
          child: ListTile(
            onTap: tap,
            title: Text(title,style: TextStyle(fontWeight: FontWeight.w400, color:  isDark?baseColor:darkModeColor,),),
            leading: Icon(icons,color: isDark?baseColor:darkModeColor,),
          ),
          color:  isDark?darkModeColor:baseColor,
          borderRadius: 15,
          depth: 35,
        ),
      ),
    );
  }
}
