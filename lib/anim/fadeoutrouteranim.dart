import 'package:flutter/material.dart';

//给启动页的动画，包含渐变可见到不可见退出
class FadeOutRouterAnim extends PageRouteBuilder{
  final RoutePageBuilder pageBuilder;
  FadeOutRouterAnim(this.pageBuilder):super(
      //transitionDuration:Duration(milliseconds: 400),//Android原生定义的中动画时间
      pageBuilder:pageBuilder,
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child
          ){
        //渐隐渐变效果
        return FadeTransition(
          opacity: Tween(begin: 1.0,end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: Tween(begin: 1.0,end: 0.0).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}