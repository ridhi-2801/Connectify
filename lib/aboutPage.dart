import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? darkModeColor : baseColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('About Page'),
          ],
        ),
      ),
    );
  }
}
