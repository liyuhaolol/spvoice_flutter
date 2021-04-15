
import 'package:flutter/material.dart';
import 'package:spvoice_flutter/res/colorlist.dart';

Widget LaunchBackground(){
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(//背景过渡色
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,1.0],
                colors: [splash_background_start, splash_background_end]
            )
        ),
      ),
      Positioned(//背景线条
          left: 0,
          right: 0,
          top: 0,
          child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Image.asset(
                'android/app/src/main/res/drawable-xxhdpi/splash_back.png',
                width: 1127/3,
                height: 812,
              )
          )
      ),
      Positioned(//图标
          left: 0,
          right: 0,
          top: 0,
          child: Padding(
              padding: EdgeInsets.only(top: 210),
              child: Image.asset(
                'android/app/src/main/res/drawable-xxhdpi/splash_logo.png',
                width: 112,
                height: 433/3,
              )
          )
      ),
      Positioned(//下方文字
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
              padding: EdgeInsets.only(bottom: 53),
              child: Image.asset(
                'android/app/src/main/res/drawable-xxhdpi/splash_bottom.png',
                width: 144,
                height: 30,
              )
          )
      ),
    ],
  );
}