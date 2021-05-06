import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget NormalFooter(){
  return CustomFooter(
    builder: (BuildContext context,LoadStatus mode){
      Widget body ;
      if(mode==LoadStatus.idle){
        body =  Text("上拉加载");
      }
      else if(mode==LoadStatus.loading){
        body =  CupertinoActivityIndicator();
      }
      else if(mode == LoadStatus.failed){
        body = Text("加载失败！点击重试！");
      }
      else if(mode == LoadStatus.canLoading){
        body = Text("松手,加载更多!");
      }
      else{
        body = Text("没有更多数据了!");
      }
      return Container(
        height: 55.0,
        child: Center(child:body),
      );
    },
  );
}