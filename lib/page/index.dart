import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,//iOS
          statusBarIconBrightness: Brightness.dark,//Android
          systemNavigationBarIconBrightness: Brightness.dark,//Android
        ),
        child: Container(),
      ),
    );
  }
}
