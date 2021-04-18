import 'package:flutter/material.dart';

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
        return FadeTransition(
          opacity: Tween(begin: 0.0,end: 1.0).animate(animation),
          child: SlideTransition(//横移返回动画
            position: Tween<Offset>(
              begin: Offset(0.0,0.0),
              end:Offset(-0.25,0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      }
  );
}


/*CurvedAnimation(
parent: animation1,
curve: Curves.fastOutSlowIn
)*/
