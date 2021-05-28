import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class AddLinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark?darkModeColor:baseColor,
      body: Padding(
        padding: const EdgeInsets.only(top : 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0),
              child: IconButton(icon: Icon(EvaIcons.close,size: 40.0,color:isDark?baseColor:darkModeColor), onPressed: (){Navigator.pop(context);}, ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20.0),
              child: Text(
                'Add Community Link',style: TextStyle(  color: isDark?baseColor:darkModeColor,fontSize: 30.0, fontFamily: 'BalsamiqSans'),
              ),
            ),
          ],
        ),
      )
    );
  }
}
