import 'package:flutter/material.dart';

class PagerRouterAnim extends PageRouteBuilder{
  final RoutePageBuilder pageBuilder;
  PagerRouterAnim(this.pageBuilder):super(
      //transitionDuration:Duration(milliseconds: 500),
      pageBuilder:pageBuilder,
      transitionsBuilder:(
          BuildContext context,
          Animation<double>animation1,
          Animation<double>animation2,
          Widget child
          ){
        //左右滑动路由动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0,0.0),
            end:Offset(0.0,0.0),
          ).animate(CurvedAnimation(
              parent: animation1,
              curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}