import 'package:flutter/material.dart';
import 'package:spvoice_flutter/anim/anim_data.dart';

//给首页的动画，包含渐变不可见到可见进入，左移动退出
class FadeInRouterAnim extends PageRouteBuilder{
  final RoutePageBuilder pageBuilder;
  FadeInRouterAnim(this.pageBuilder):super(
      transitionDuration:Duration(milliseconds: 500),//Android原生定义的长动画时间
      pageBuilder:pageBuilder,
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child
          ){
        //渐隐渐变效果
        return FadeInAnim(
            animation,
            ExitAnim(
                secondaryAnimation,
                child)
        );
      }
  );
}


/*CurvedAnimation(
parent: animation1,
curve: Curves.fastOutSlowIn
)*/
