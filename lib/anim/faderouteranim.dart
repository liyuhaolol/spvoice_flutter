import 'package:flutter/material.dart';

class FadeRouterAnim extends PageRouteBuilder{
  final RoutePageBuilder pageBuilder;
  FadeRouterAnim(this.pageBuilder):super(
      //transitionDuration:Duration(seconds: 2),
      pageBuilder:pageBuilder,
      transitionsBuilder:(
          BuildContext context,
          Animation<double>animation1,
          Animation<double>animation2,
          Widget child
          ){
        //渐隐渐变效果
        return FadeTransition(
          opacity: Tween(begin: 0.0,end: 1.0).animate(
              CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn
              )
          ),
          child: child,
        );
      }
  );
}