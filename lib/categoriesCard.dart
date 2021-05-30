import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';

import 'categoryPage.dart';
import 'constants.dart';

class CategoriesCard extends StatelessWidget {
  final categoryIcon;
  final categoryName;
  final linksDataIds;

  CategoriesCard({
    this.categoryName,
    this.categoryIcon,
    this.linksDataIds,
  });

  IconData? iconData;
  Future<IconData?> getIcon() async{
    iconData = iconMap[categoryIcon];
    return iconData;
  }


  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CategoryPage(
              categoryName: categoryName,
              linksDataIds: linksDataIds,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: baseColor,
          ),
          child: Center(
            child: ClayContainer(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      size: y / 13,
                      color: isDark ? baseColor : darkModeColor,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      categoryName,
                      style: TextStyle(
                        color: isDark ? baseColor : darkModeColor,
                      ),
                    ),
                  ],
                ),
              ),
              color: isDark ? darkModeColor : baseColor,
              borderRadius: 15,
              depth: 35,
              spread: 6,
              width: y / 4,
              height: y / 4,
            ),
          ),
        ),
      ),
    );
  }
}