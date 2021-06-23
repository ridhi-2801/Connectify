import 'package:flutter/material.dart';
import '../categoryPage.dart';
import '../constants.dart';

class SearchViewScreen extends StatelessWidget {
  final list;
  final isCategorySearch;
  const SearchViewScreen({Key? key, this.list, this.isCategorySearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: list.length == 0
            ? Center(
                child: Text(
                  "No Groups to display!!",
                  style: TextStyle(
                    fontSize: 0.03 * MediaQuery.of(context).size.height,
                    fontFamily: 'Poppins-SemiBold',
                    color: darkModeColor,
                  ),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  if (isCategorySearch) {
                    final category = list[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryPage(
                            categoryName: list[index].get('title'),
                            linksDataIds: list[index].get('linksData'),
                          );
                        }));
                      },
                      title: Text(category.get('title')),
                    );
                  } else {
                    final linkData = list[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(linkData.get('image')),
                      ),
                      title: Text(linkData.get('name')),
                      trailing: IconButton(
                          onPressed: () {
                            launchURL(linkData.get('link'));
                          },
                          icon: Icon(Icons.person_add_alt_1_rounded)),
                    );
                  }
                }));
  }
}
