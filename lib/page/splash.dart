import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spvoice_flutter/view/launchbackground.dart';

class PageSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        /*statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor:Colors.white,*/
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light
      ),
      child: Stack(
        children: [
          LaunchBackground(),//启动图
          //SafeArea(child: Container(color: Colors.blue,))
        ],
      ),
    );
  }
}
