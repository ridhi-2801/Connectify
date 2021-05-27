import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clay_containers/clay_containers.dart';
import 'constants.dart';

class LinkCards extends StatelessWidget {
  final String groupImage;
  final String groupNameText;
  final String linkText;

  LinkCards({
      required this.groupImage,
      required this.groupNameText,
      required this.linkText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClayContainer(
            borderRadius: 10,
            height: 200,
            width: 150,
            depth: 40,
            spread: 5,
            color: isDark?darkModeColor:baseColor,
            curveType: CurveType.none,
//            decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(4.0),
//                boxShadow: <BoxShadow>[
//                  BoxShadow(
//                    color: Color(0xff075E54),
//                    offset: Offset(0.0,5.0),
//                    blurRadius:6,
//                  )
//                ]
//            ),
            child: Column(
              children: [
                Divider(
                  color: isDark?baseColor:darkModeColor,
                  thickness: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blueAccent,
                    // backgroundImage: AssetImage(groupImage),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      groupNameText,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark?baseColor:darkModeColor,),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text: linkText,
                    linkStyle: TextStyle(color:  isDark?baseColor:darkModeColor, fontSize: 12),
                    options: LinkifyOptions(humanize: true),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
                color: isDark?baseColor:darkModeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )),
            child: Center(
                child: GestureDetector(
              onTap: () {
                Alert(
                    context: context,
                    title: "Share By:",
                    content: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.whatsapp),
                                onPressed: () async {
                                  SocialShare.shareWhatsapp(linkText)
                                      .then((data) {
                                    print(data);
                                    Navigator.pop(context);
                                  });
                                },
                                color: Color(0xff075E54),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.telegram),
                                onPressed: () async {
                                  SocialShare.shareTelegram(linkText)
                                      .then((data) {
                                    print(data);
                                    Navigator.pop(context);
                                  });
                                },
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.twitter),
                                onPressed: () {
                                  SocialShare.shareTwitter(
                                      "Hey! I am inviting you to join the group",
                                      hashtags: [
                                        "hey",
                                        "invite",
                                        "join",
                                        "group"
                                      ],
                                      url: linkText);
                                  Navigator.pop(context);
                                },
                                color: Color(0xff00acee),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.copy),
                                onPressed: () {
                                  SocialShare.copyToClipboard(linkText);
                                  Navigator.pop(context);
                                },
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () => Navigator.pop(context),
                        color: Color(0xff075E54),
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();
              },
              child: Text(
                "Share",
                style:
                    TextStyle(color: isDark?darkModeColor:baseColor, fontWeight: FontWeight.bold),
              ),
            )),
          )
        ],
      ),
    );
  }
}
