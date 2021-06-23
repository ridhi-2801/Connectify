import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import '../screens/CategoriesPage/categoryPage.dart';
import '../Constants/constants.dart';

class CategoriesCard extends StatelessWidget {
  final categoryIcon;
  final categoryName;
  final linksDataIds;
  final double borderRadius;
  final double sizeRatio;
  final int iconRatio;

  CategoriesCard({
    this.categoryName,
    this.categoryIcon,
    this.linksDataIds,
    this.borderRadius = 15,
    this.sizeRatio =4,
    this.iconRatio = 13,
  });

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CategoryPage(
              categoryName: categoryName,
              linksDataIds: linksDataIds,
            );
          }));
        },
        child: Center(
          child: ClayContainer(
            customBorderRadius: BorderRadius.circular(borderRadius),
            curveType: isDark ? CurveType.concave : CurveType.none,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categoryIcon,
                    size: y / iconRatio,
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
            depth: 40,
            spread: 5,
            width: y / sizeRatio,
            height: y / sizeRatio,
          ),
        ),
      ),
    );
  }
}