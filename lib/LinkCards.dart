import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_share/social_share.dart';
import 'constants.dart';
import 'package:share_plus/share_plus.dart';

class LinkCards extends StatelessWidget {
  final String linkImage;
  final String linkTitle;
  final String link;
  final relatedCategories;
  final platform;

  LinkCards(
      {required this.linkImage,
      required this.linkTitle,
      required this.link,
      required this.relatedCategories,
      required this.platform});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 6,
            shadowColor: isDark ?baseColor : darkModeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
            ),
            color: isDark ? darkModeColor : baseColor,
            child: Container(
              color: Colors.transparent,
              width: 150,
              child: Column(
                children: [
                  Divider(
                    color: isDark ? baseColor : darkModeColor,
                    thickness: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: linkTitle.length > 20 ? 30 : 35,
                      backgroundColor: Colors.blueAccent,
                      backgroundImage: NetworkImage(
                          linkImage,),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 4.0),
                      child: Flexible(
                        child: Text(
                          linkTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: linkTitle.length > 20 ? 12.5 : 15,
                            color: isDark ? baseColor : darkModeColor,
                          ),
                        ),
                      )),
                  platformIconMap.containsKey(platform) == true ?
                  Icon(platformIconMap[platform],size: linkTitle.length > 20 ? 16.5 : 20.0,color: isDark? Colors.white : Colors.black,) : Text(platform),
                  SizedBox(height: 8.0,),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
                color: isDark ? baseColor : darkModeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                )),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: TextButton(
                      onPressed: (){
                        launchURL(link);
                      },
                      child: Text(
                        "Join",
                        style: TextStyle(
                            color: isDark ? darkModeColor : baseColor,
                            fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => share(context, link),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VerticalDivider(color: isDark ? darkModeColor : baseColor,thickness: 0.4),
                        Icon(FontAwesomeIcons.share,
                          color: isDark ? darkModeColor : baseColor,
                          size: 14.0,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  void share(BuildContext context , String text){
    String message = "$text\nShared Via Connectify App";
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Shared from app Connectify',
    sharePositionOrigin: box.localToGlobal(Offset.zero) &  box.size,);
  }
}

// Alert(
//     context: context,
//     title: "Share By:",
//     content: Padding(
//       padding: const EdgeInsets.only(top: 28.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(FontAwesomeIcons.whatsapp),
//                 onPressed: () async {
//                   SocialShare.shareWhatsapp(link).then((data) {
//                     print(data);
//                     Navigator.pop(context);
//                   });},
//                 color: Color(0xff075E54),
//               ),
//               IconButton(
//                 icon: Icon(FontAwesomeIcons.telegram),
//                 onPressed: () async {
//                   SocialShare.shareTelegram(link).then((data) {
//                     print(data);
//                     Navigator.pop(context);
//                   });
//                 },
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(FontAwesomeIcons.twitter),
//                 onPressed: () {
//                   SocialShare.shareTwitter(
//                       "Hey! I am inviting you to join the group",
//                       hashtags: [
//                         "hey",
//                         "invite",
//                         "join",
//                         "group"
//                       ],
//                       url: link);
//                   Navigator.pop(context);
//                 },
//                 color: Color(0xff00acee),
//               ),
//               IconButton(
//                 icon: Icon(FontAwesomeIcons.copy),
//                 onPressed: () {
//                   SocialShare.copyToClipboard(link);
//                   Navigator.pop(context);
//                 },
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     buttons: [
//       DialogButton(
//         onPressed: () => Navigator.pop(context),
//         color: Color(0xff075E54),
//         child: Text(
//           "Done",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//       )
//     ]).show();