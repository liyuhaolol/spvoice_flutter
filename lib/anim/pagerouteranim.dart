import 'package:flutter/material.dart';

//给一般页面的动画，包含左移进入，左移退出
class PagerRouterAnim extends PageRouteBuilder{
  final RoutePageBuilder pageBuilder;
  PagerRouterAnim(this.pageBuilder):super(
      //transitionDuration:Duration(milliseconds: 500),
      pageBuilder:pageBuilder,
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child
          ){
        //左右滑动路由动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0,0.0),
            end:Offset(0.0,0.0),
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0,0.0),
              end:Offset(-1.0,0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}