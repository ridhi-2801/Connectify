import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

class linkCards extends StatelessWidget {
  const linkCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0xff075E54),
                    offset: Offset(0.0,10.0),
                    blurRadius:6,
                  )
                ]
            ),
            child: Column(
              children: [
                Divider(
                  color: Colors.black,
                  thickness: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor:  Color(0xff075E54),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Text("Name of group",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),)
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 8,right: 8),
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text: "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e",
                    linkStyle: TextStyle(color: Colors.black,fontSize: 12),
                    options: LinkifyOptions(humanize: true),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 30,
            width: 120,
            child: Center(
                child:GestureDetector(
                  onTap: (){
                    Alert(
                      context: context,
                      title: "Share By:",
                      content:  Padding(
                        padding: const EdgeInsets.only(top:28.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(icon: Icon(FontAwesomeIcons.whatsapp), onPressed: () async {
                                  SocialShare.shareWhatsapp(
                                      "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e")
                                      .then((data) {
                                    print(data);
                                    Navigator.pop(context);
                                  });
                                },color: Color(0xff075E54),),
                                IconButton(icon: Icon(FontAwesomeIcons.telegram),  onPressed: () async {
                                  SocialShare.shareTelegram(
                                      "https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e")
                                      .then((data) {
                                    print(data);
                                    Navigator.pop(context);
                                  });
                                },color: Colors.blue,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(icon: Icon(FontAwesomeIcons.twitter), onPressed: (){
                                  SocialShare.shareTwitter(
                                      "Hey! I am inviting you to join the group",
                                      hashtags: ["hey", "invite", "join", "group"],url:"https://your-url-here/");
                                  Navigator.pop(context);
                                },color: Color(0xff00acee),),
                                IconButton(icon: Icon(FontAwesomeIcons.copy), onPressed: (){
                                  SocialShare.copyToClipboard("https://chat.whatsapp.com/Egn2G0hhDzD9tgmVdgUl9e");
                                  Navigator.pop(context);
                                },color: Colors.black,),
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
                        ]
                    ).show();
                  },
                  child: Text("Share",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                )
            ),
          )
        ],
      ),
    );
  }
}
