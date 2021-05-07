import 'package:flutter/material.dart';
import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/utils/time_utils.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';

///空占位item
Widget EmptyListItem(BuildContext context,double viewPortHeight){
  return Container(
    height: viewPortHeight,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/icon_nocontent.png',
            height: 90,
            width: 100,),
          SizedBox(height: 20,),
          Text(news_list_empty,
            style: TextStyle(
                fontSize: 14,
                color: gray_e5
            ),
          ),
        ],
      ),
    ),
  );
}

///纯文稿件
Widget TextListItem(News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(Text(news.contentSource,
      style: TextStyle(
          fontSize: 12,
          color: gray_b3
      ),
    ));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(Text(TimeUtils.getShowTime(news.contentReleaseTime),
    style: TextStyle(
        fontSize: 12,
        color: gray_b3
    ),
  ));
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          showToast('纯文稿件');
        },
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.contentTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: gray_5
                ),),
              SizedBox(height: 15,),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: bottomLine,
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Container(
          color: gray_ea,
          height: 0.5,
        ),
      ),
    ],
  );
}

///图文稿件
Widget OnePicListItem(News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(Text(news.contentSource,
      style: TextStyle(
          fontSize: 12,
          color: gray_b3
      ),
    ));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(Text(TimeUtils.getShowTime(news.contentReleaseTime),
    style: TextStyle(
        fontSize: 12,
        color: gray_b3
    ),
  ));
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          showToast('图文稿件');
        },
        child: Container(
          height: 85,
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                color: Colors.amber,
                child: AspectRatio(
                  aspectRatio: 16/9,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(news.contentTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: gray_5,
                          height: 1.2,
                        ),),
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: bottomLine,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Container(
          color: gray_ea,
          height: 0.5,
        ),
      ),
    ],
  );
}