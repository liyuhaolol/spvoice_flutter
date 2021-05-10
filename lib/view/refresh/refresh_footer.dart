import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/view/news_view.dart';

const double _footerHeight = 60;///图文稿件item高度

Widget NormalFooter(){
  return CustomFooter(
    builder: (BuildContext context,LoadStatus mode){
      Widget body ;
      if(mode==LoadStatus.idle || mode == LoadStatus.canLoading){
        body =  Text(footer_complete,
            style: TextStyle(
                fontSize: 14,
                color: gray_9b
            ));
      }
      else if(mode==LoadStatus.loading){
        body =  Text(footer_loading,
            style: TextStyle(
                fontSize: 14,
                color: gray_9b
            ));
      }
      else if(mode == LoadStatus.failed){
        body = Text(footer_fail,
            style: TextStyle(
                fontSize: 14,
                color: gray_9b
            ));
      }
      else{
        body = Text(footer_end,
        style: TextStyle(
          fontSize: 14,
          color: gray_9b
        ));
      }
      return Container(
        height: _footerHeight,
        child: Center(child:body),
      );
    },
  );
}

///刷新触发距离，footer上面，3个图文稿件的高度
double getTriggerDistance(){
  return getOnePicItemHeight() * 4 + _footerHeight;
}