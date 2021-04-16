
import 'package:flutter/material.dart';
import 'package:spvoice_flutter/anim/pagerouteranim.dart';
import 'package:spvoice_flutter/page/index.dart';
import 'package:spvoice_flutter/page/index/setting.dart';
import 'package:spvoice_flutter/page/splash.dart';

class MyRouters{
  static final String PAGE_SPLASH = '/';
  static final String PAGE_INDEX = '/index';
  static final String PAGE_SETTING = '/setting';


  static final routes = {
    PAGE_SPLASH:(context)=>PageSplash(),
    PAGE_INDEX:(context)=>PageIndex(),
    PAGE_INDEX:(context)=>PageIndex(),
    PAGE_SETTING:(context,{arguments})=>PageSetting(arguments:arguments),
    //PAGE_INDEX:(context,{arguments})=>SearchPage(arguments:arguments),
  };


  static Function onGenerateRoute = (RouteSettings settings){
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
  };
}


