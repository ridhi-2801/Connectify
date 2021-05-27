import 'package:clay_containers/clay_containers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


bool isDark=false;

void darkTheme(){

   

}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container( 
        child: Scaffold(
            body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8.0),
            child: IconButton(
              icon: Icon(
                EvaIcons.arrowIosBack,
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
                  color: Colors.black, fontSize: 40.0, fontFamily: 'BalsamiqSans'),
            ),
          ),
          SizedBox(
            height: 25.0),
              SettingsListTitles(title: "Switch Theme", icons: EvaIcons.moon,tap: (){
                if(isDark==false) {
                  isDark=true;
                  darkTheme();
                }
              },),

              Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: SettingsListTitles(title: "Rate and Review", icons: EvaIcons.star,),
              ),

              Padding(
                padding: const EdgeInsets.only(top:18.0),
                child: SettingsListTitles(title: "About", icons: EvaIcons.people,),
              ),
        ])),
      ),
    );
  }
}

class SettingsListTitles extends StatelessWidget {

 final String title;
 final IconData icons;
 final  Function tap;
 SettingsListTitles({@required this.title,@required this.icons,@required this.tap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: baseColor,
        ),
        child: ClayContainer(
          child: ListTile(
            onTap: tap,
            title: Text(title,style: TextStyle(fontWeight: FontWeight.w400),),
            leading: Icon(icons,color: Colors.black,),
          ),
          color: baseColor,
          borderRadius: 15,
          depth: 35,
        ),
      ),
    );
  }
}
