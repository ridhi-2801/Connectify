import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_share/social_share.dart';
import 'constants.dart';

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
//            borderRadius: 6,
//            width: 150,
//            depth: 50,
//            spread: 6,
            color: isDark ? darkModeColor : baseColor,
//            curveType: CurveType.none,
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
                                  SocialShare.shareWhatsapp(link).then((data) {
                                    print(data);
                                    Navigator.pop(context);
                                  });},
                                color: Color(0xff075E54),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.telegram),
                                onPressed: () async {
                                  SocialShare.shareTelegram(link).then((data) {
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
                                      url: link);
                                  Navigator.pop(context);
                                },
                                color: Color(0xff00acee),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.copy),
                                onPressed: () {
                                  SocialShare.copyToClipboard(link);
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){print('join');},
                    child: Text(
                      "Join",
                      style: TextStyle(
                          color: isDark ? darkModeColor : baseColor,
                          fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 15.0),
                    ),
                  ),
                  SizedBox(width: 0.5,),
                  InkWell(
                      onTap: (){print('BalsamiqSans');},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.1,top: 0.1),
                            child: VerticalDivider(color: isDark ? darkModeColor : baseColor,thickness: 0.4),
                          ),
                          Icon(FontAwesomeIcons.share,
                            color: isDark ? darkModeColor : baseColor,
                            size: 15.0,),
                        ],
                      ),
                    ),
                      ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
