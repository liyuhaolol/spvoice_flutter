import 'package:cached_network_image/cached_network_image.dart';
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
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
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
              _getTitleText(news.contentTitle),
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
      _divider(),
    ],
  );
}

///图文稿件
Widget OnePicListItem(News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = '';
  if(news.contentListImg != null && news.contentListImg.length > 0){
    imgUrl = news.contentListImg[0];
  }
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
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: _getImage(imgUrl),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: _getTitleText(news.contentTitle,maxlines: 2),
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
      _divider(),
    ],
  );
}

///三图稿件
Widget ThreePicListItem(BuildContext context,News news){
  double screenWidth = MediaQuery.of(context).size.width;
  double img_2x = (screenWidth - 33) / 3 * 2;///2倍图片大小
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  List<String> imageList = [];
  for(int i = 0;i < 3;i++){
    try{
      imageList.add(news.contentListImg[i]);
    }catch(e){
      imageList.add('');
    }
  }
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          showToast('三图稿件');
        },
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: img_2x / 16 *9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: img_2x,
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: _getImage(imageList[0]),),
                    ),
                    SizedBox(width: 3,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: Container(child: _getImage(imageList[1]),width: double.infinity,)),
                          SizedBox(height: 3,),
                          Flexible(child: Container(child: _getImage(imageList[2]),width: double.infinity,)),
                        ],
                      ),
                    ),
                  ],),
              ),
              SizedBox(height: 10,),
              _getTitleText(news.contentTitle,maxlines: 2),
              SizedBox(height: 10,),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: bottomLine,
              )
            ],
          ),
        ),
      ),
      _divider(),
    ],
  );
}

Widget BigPicListItem(News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = '';
  if(news.contentListImg != null && news.contentListImg.length > 0){
    imgUrl = news.contentListImg[0];
  }
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          showToast('图集稿件');
        },
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: _getImage(imgUrl),
                ),
              ),
              SizedBox(height: 10,),
              _getTitleText(news.contentTitle,maxlines: 2),
              SizedBox(height: 10,),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: bottomLine,
              )
            ],
          ),
        ),
      ),
      _divider(),
    ],
  );
}

Widget VideoListItem(News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = '';
  if(news.contentListImg != null && news.contentListImg.length > 0){
    imgUrl = news.contentListImg[0];
  }
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          showToast('视频稿件');
        },
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Stack(
                    children: [
                      Container(color: Colors.black,),
                      _getVideoImage(imgUrl),
                      Center(
                        child: Image.asset('images/icon_play.png',width: 60,height: 60,),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              _getTitleText(news.contentTitle,maxlines: 2),
              SizedBox(height: 10,),
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: bottomLine,
              )
            ],
          ),
        ),
      ),
      _divider(),
    ],
  );
}

Widget _getSmallText(String content){
  return Text(content,
    style: TextStyle(
        fontSize: 12,
        color: gray_b3
    ),
  );
}

Widget _getTitleText(String content,{int maxlines = 1}){
  return Text(content,
    maxLines: maxlines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: 16,
      color: gray_5,
      height: 1.2,
    ),);
}

Widget _getImage(String url){
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Container(color: gray_e5,),
    errorWidget: (context, url, error) => Container(color: gray_e5,),
    fit: BoxFit.cover,
    alignment: Alignment.lerp(Alignment.topLeft, Alignment.topRight, 0.5),
    fadeInDuration: Duration(milliseconds: 0),
    fadeOutDuration: Duration(milliseconds: 0),
  );
}

Widget _getVideoImage(String url){
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Container(color: Colors.black,),
    errorWidget: (context, url, error) => Container(color: Colors.black,),
    fit: BoxFit.contain,
    width: double.infinity,
    height: double.infinity,
    fadeInDuration: Duration(milliseconds: 0),
    fadeOutDuration: Duration(milliseconds: 0),
  );
}

Widget _divider(){
  return Padding(
    padding: EdgeInsets.only(left: 15,right: 15),
    child: Container(
      color: gray_ea,
      height: 0.5,
    ),
  );
}