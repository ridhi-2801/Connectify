import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: ListView(
            children: [

              Center(child: Text("About Us",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text("Our Mission",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
              ),
            SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right:20),
                child: Text(
                    "Our mission is to connect people round the globe to learn and grow together.",
                    style: TextStyle(fontSize: 13)),
              ),
              SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://www.incimages.com/uploaded_files/image/1920x1080/getty_160945425_970647970450083_44809.jpg",

                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text("Our Team",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 40),
                child: Container(
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://media-exp1.licdn.com/dms/image/C5603AQFn4G5OyeKc_A/profile-displayphoto-shrink_800_800/0/1612438527208?e=1629936000&v=beta&t=5Of-iAg0EDBvD_nIi6BsCKtWIr67sG3UEX81XbLLm6c"),
                          radius: 40,
                        ),
                      ),

                      Container(

                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ridhi Jain", style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900)),
                              Text("Flutter Developer",
                                  style: TextStyle(fontSize: 12)),
                              Text("Founder", style: TextStyle(fontSize: 11)),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Github", style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                    ),),
                                  Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Linked in", style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                    ),)
                                ],
                              )
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 40),
                child: Container(
                  color: Colors.black12,
                  child: Row(

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://media-exp1.licdn.com/dms/image/C4E03AQGu95m4alP_og/profile-displayphoto-shrink_800_800/0/1598511572312?e=1629936000&v=beta&t=l8QDzBWi58Rr5-QMmWvr34tg14g7p_HG1c93F4ulCu4"),
                          radius: 40,
                        ),
                      ),

                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mohd Aamir", style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900)),
                              Text("Flutter Developer",
                                  style: TextStyle(fontSize: 12)),
                              Text("Founder", style: TextStyle(fontSize: 11)),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Github", style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                    ),),
                                  Card(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Linked in", style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                    ),)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}