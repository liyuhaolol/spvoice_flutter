
import 'package:flutter/material.dart';
import 'package:spvoice_flutter/page/index/setting.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/routers/routers.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';

class MainBottom extends StatelessWidget {
  List indexData=[
    {
      'name':index_video,
      'icon':'images/icon_video.png',
      'router':index_video
    },
    {
      'name':index_paper,
      'icon':'images/ico_epaper.png',
      'router':index_paper
    },
    {
      'name':index_radio,
      'icon':'images/ico_diantai.png',
      'router':index_radio
    },
    {
      'name':index_setting,
      'icon':'images/icon_setting.png',
      'router':MyRouters.PAGE_SETTING
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          children: _getIndexData(context),
        ));
  }

  //加载底部导航栏
  List<Widget> _getIndexData(BuildContext context){
    var temp = indexData.map((e) => Expanded(//视频
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(
                context,
                e['router'],
                arguments: {
                  'title':e['name'],
                }
                );
          },
          child: Container(
            color: Colors.white,
            height: 50,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  e['icon'],
                  height: 24,
                  width: 24,),
                SizedBox(height: 3,),
                Text(e['name'],
                  style: TextStyle(
                    fontSize: 12,
                    color: gray_a7,
                  ),
                ),
              ],
            ),
          ),
        )
    ));

    return temp.toList();
  }
}
