import 'package:flutter/material.dart';

CurvedAnimation _CurvedAnim(Animation<double> animation){
  return CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn
  );
}

FadeTransition NoAnimIn(Animation<double> animation,Widget child){
  return FadeTransition(
    opacity: Tween(begin: 1.0,end: 1.0).animate(_CurvedAnim(animation)),
    child: child,
  );
}

SlideTransition EnterAnim(Animation<double> animation,Widget child){
  return SlideTransition(
    position: Tween<Offset>(
      begin: Offset(1.0,0.0),
      end:Offset(0.0,0.0),
    ).animate(_CurvedAnim(animation)),
    child: child,
  );
}

SlideTransition ExitAnim(Animation<double> secondaryAnimation,Widget child){
  return SlideTransition(//横移返回动画
    position: Tween<Offset>(
      begin: Offset(0.0,0.0),
      end:Offset(-0.25,0.0),
    ).animate(_CurvedAnim(secondaryAnimation)),
    child: FadeTransition(//变半透明
      opacity: Tween(begin: 1.0,end: 0.5).animate(_CurvedAnim(secondaryAnimation)),
      child: child,
    ),
  );
}

FadeTransition FadeInAnim(Animation<double> animation,Widget child){
  return FadeTransition(
    opacity: Tween(begin: 0.0,end: 1.0).animate(_CurvedAnim(animation)),
    child: child,
  );
}

FadeTransition FadeOutAnim(Animation<double> secondaryAnimation,Widget child){
  return FadeTransition(
    opacity: Tween(begin: 1.0,end: 0.0).animate(_CurvedAnim(secondaryAnimation)),
    child: child,
  );
}