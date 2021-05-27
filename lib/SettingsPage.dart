import 'package:clay_containers/clay_containers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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
              SettingsListTitles(title: "Theme", symbol: "🌙",),

              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: SettingsListTitles(title: "Rate and Review", symbol: "⭐",),
              ),

              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: SettingsListTitles(title: "About", symbol: "🆎",),
              ),
        ])),
      ),
    );
  }
}
final Color baseColor = Colors.white;
class SettingsListTitles extends StatelessWidget {

 final String title;
 final String symbol;
 SettingsListTitles({this.title,this.symbol});
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
            title: Text(title,style: TextStyle(fontWeight: FontWeight.w500),),
            leading: Text(symbol,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          ),
          color: baseColor,
          borderRadius: 15,
          depth: 35,
        ),
      ),
    );
  }
}
