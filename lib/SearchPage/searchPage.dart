import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class SearchPage extends StatefulWidget {
  final searchType;
  SearchPage({this.searchType});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchData = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController textEditingController = TextEditingController();
  String textSearch = 'some loreal epsum';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Container(
            height: 50 * MediaQuery.of(context).size.height,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    textEditingController.clear();
                    // Navigator.of(context).pop();
                  },
                ),
                hintText: "Search a ${widget.searchType} ...",
              ),
              // keyboardType: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  if (value == "") {
                    textSearch = "99";
                  } else {
                    textSearch = value;
                  }
                });
                print(value);
              },
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot> (
          stream: widget.searchType == "Category"
              ? firebaseFirestore.collection("Categories")
              .orderBy('title')
              .startAt([textSearch.toLowerCase()])
              .endAt([textSearch.toLowerCase() + '\uf8ff'])
              .snapshots()
              :
              firebaseFirestore.collection("LinksData")
                  .orderBy('name')
                  .startAt([textSearch.toLowerCase()])
                  .endAt([textSearch.toLowerCase() + '\uf8ff'])
                  .snapshots(),

          builder: (context, snapshot) {
            if (snapshot.hasData)
              snapshot.data!.docs.forEach((result) {
                print(result.data());
                // if (StoryData.fromSnapshot(result)
                //     .title
                //     .toLowerCase()
                //     .contains(textSearch.toLowerCase())) {
                //   allStories.add(StoryData.fromSnapshot(result));
                // }else if (StoryData.fromSnapshot(result)
                //     .content
                //     .toLowerCase()
                //     .contains(textSearch.toLowerCase())) {
                //   allStories.add(StoryData.fromSnapshot(result));
                // }
              });

            return snapshot.data!.docs.length == 0
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/notFound.png',
                  //   height: 243 * MediaQuery.of(context).size.height,
                  //   width: 243 * MediaQuery.of(context).size.height,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0 * MediaQuery.of(context).size.height,
                    ),
                    child: Text(
                      "No Stories to display!!",
                      style: TextStyle(
                        fontSize:
                        18.0 * MediaQuery.of(context).size.height,
                        fontFamily: 'Poppins-SemiBold',
                        color: darkModeColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
                :
            SearchViewScreen(
              // list: allStories,
              isCategorySearch: widget.searchType == "Category" ? true : false,
            );
          },
        ),
      ),
    );
  }
}

class SearchViewScreen extends StatelessWidget {
  final list;
  final isCategorySearch;
  const SearchViewScreen({Key? key, this.list , this.isCategorySearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double .infinity,
      padding: EdgeInsets.only(
          left: 12.0 ,
          right: 12.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (context, index) {
            if(isCategorySearch){
              final category = list[index];
              //todo
              return ListTile(
                onTap: (){},
                title: Text(category.title),
              );;

            }else{
              final linkData = list[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(linkData.image),
                ),
                title: Text(linkData.name),
                trailing: IconButton(
                  onPressed: () {
                    //todo
                  },
                    icon : Icon(Icons.person_add_alt_1_rounded)),
              );
            }

          })
    );
  }
}
