import 'package:flutter/material.dart';
import 'package:spvoice_flutter/anim/fadeinrouteranim.dart';
import 'package:spvoice_flutter/anim/fadeoutrouteranim.dart';
import 'package:spvoice_flutter/anim/pagerouteranim.dart';
import 'package:spvoice_flutter/page/detail/news_detail.dart';
import 'package:spvoice_flutter/page/index.dart';
import 'package:spvoice_flutter/page/index/setting.dart';
import 'package:spvoice_flutter/page/splash.dart';

class MyRouters{
  static const String PAGE_SPLASH = '/';
  static const String PAGE_INDEX = '/index';
  static const String PAGE_SETTING = '/setting';
  static const String PAGE_NEWS_DETAIL = '/news_detail';


  static final routes = {
    PAGE_SPLASH:(context)=>PageSplash(),
    PAGE_INDEX:(context)=>PageIndex(),
    //PAGE_INDEX:(context)=>PageIndex(),
    PAGE_SETTING:(context,{arguments})=>PageSetting(arguments:arguments),
    PAGE_NEWS_DETAIL:(context,{arguments})=>NewsDetail(arguments:arguments),
    //PAGE_INDEX:(context,{arguments})=>SearchPage(arguments:arguments),
  };

  static RouteFactory onGenerateRoute = (RouteSettings settings){
    final String name = settings.name;
    final Function contentBuilder = routes[name];
    if(contentBuilder != null){
      //启动图是要使用渐变动画
      switch(name){
        case PAGE_SPLASH:
          return FadeOutRouterAnim((context, animation, secondaryAnimation)=>contentBuilder(context));
          break;
        case PAGE_INDEX:
          return FadeInRouterAnim((context, animation, secondaryAnimation)=>contentBuilder(context));
          break;
        default:
          if(settings.arguments != null){
            return PagerRouterAnim((context, animation, secondaryAnimation)=>contentBuilder(context,arguments:settings.arguments));
          }else{
            return PagerRouterAnim((context, animation, secondaryAnimation)=>contentBuilder(context));
          }
          break;
      }
    }
    return null;
  };



/*  static Function onGenerateRoute = (RouteSettings settings){
    final String name = settings.name;
    final Function contentBuilder = routes[name];
    if(contentBuilder != null){
      if(settings.arguments != null){
        return MaterialPageRoute(builder: (context)=>contentBuilder(context,arguments:settings.arguments));
      }else{
        return MaterialPageRoute(builder: (context)=>contentBuilder(context));
      }
    }
    return null;
  };*/
}


