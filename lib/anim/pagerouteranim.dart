import 'package:flutter/material.dart';
import 'package:spvoice_flutter/anim/anim_data.dart';

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
        return EnterAnim(
            animation,
            ExitAnim(
                secondaryAnimation,
                child)
        );
      }
  );
}