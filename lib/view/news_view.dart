import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/routers/routers.dart';
import 'package:spvoice_flutter/utils/time_utils.dart';

const double _itemHeight = 85;///图文稿件item高度

///轮播图
Widget SwiperView(BuildContext context,List<News> bannerList){
  double screenWidth = MediaQuery.of(context).size.width;
  double itemHeight = screenWidth / 16 * 9 +20;
  return Container(
    height: itemHeight,
    child: Swiper(
      itemCount: bannerList.length,
      itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              _getImage(_getImageUrl(bannerList[index])),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenWidth,
                  height: 32,
                  color: black_80,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text(bannerList[index].contentTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        );
      },
      autoplay: true,
      pagination: new SwiperPagination(builder: DotSwiperPaginationBuilder(
        color: gray_e6,
        activeColor: gray_b3,
        size: 5,
        activeSize: 5,
        space: 5,
      ),
      margin: EdgeInsets.all(0)),
      autoplayDelay: 5000,
      duration: 200,
      onTap: (index)=>_goToWebDetail(context,bannerList[index]),
    ),
  );
}

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
Widget TextListItem(BuildContext context,News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  return Column(
    children: [
      GestureDetector(
        onTap: ()=>_goToWebDetail(context,news),
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
Widget OnePicListItem(BuildContext context,News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallTextEllipsis(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = _getImageUrl(news);
  return Column(
    children: [
      GestureDetector(
        onTap: ()=>_goToWebDetail(context,news),
        child: Container(
          height: _itemHeight,
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
        onTap: ()=>_goToWebDetail(context,news),
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

///图集稿件
Widget BigPicListItem(BuildContext context,News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = _getImageUrl(news);
  return Column(
    children: [
      GestureDetector(
        onTap: ()=>_goToWebDetail(context,news),
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

///视频稿件
Widget VideoListItem(BuildContext context,News news){
  List<Widget> bottomLine = [];
  if(news.contentSource != null && news.contentSource.isNotEmpty){
    bottomLine.add(_getSmallText(news.contentSource));
    bottomLine.add(SizedBox(width: 10,));
  }
  bottomLine.add(_getSmallText(TimeUtils.getShowTime(news.contentReleaseTime)));
  String imgUrl = _getImageUrl(news);
  return Column(
    children: [
      GestureDetector(
        onTap: ()=>_goToWebDetail(context,news),
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

Widget _getSmallTextEllipsis(String content){
  return Container(
    constraints: BoxConstraints(maxWidth: 100),
    child: Text(content,
      style: TextStyle(
          fontSize: 12,
          color: gray_b3,
          overflow: TextOverflow.ellipsis
      ),
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
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.lerp(Alignment.topLeft, Alignment.topRight, 0.5)!,
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

String _getImageUrl(News news){
  String imgUrl = '';
  if(news.contentListImg != null && news.contentListImg.length > 0){
    imgUrl = news.contentListImg[0];
  }
  return imgUrl;
}

void _goToWebDetail(BuildContext context,News news){
  ///这里就先不做类型判断了因为是个范例，不存在多种web详情页
  Navigator.pushNamed(
      context,
      MyRouters.PAGE_NEWS_DETAIL,
      arguments: {
        'news':news,
      }
  );
}

double getOnePicItemHeight(){
  return _itemHeight;
}