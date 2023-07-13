
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';
import 'package:spvoice_flutter/view/commonheadbar.dart';

class PageSetting extends StatefulWidget {
  final arguments;
  String _title = '';
  bool status = false;

  PageSetting({this.arguments}){
    if(arguments != null){
      _title = arguments['title'];
    }
  }
  @override
  _PageSettingState createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            //iOS
            statusBarBrightness: Brightness.light,
            //Android
            statusBarIconBrightness: Brightness.dark,
            //Android
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Column(
              children: [
                CommonHead(widget._title,hasLine: false,),
                headIconArea(),
                LineHeightBig(),
                Feedback(),
                LineHeightSmall(),
                Push(),
                LineHeightSmall(),
                Version(),
                LineHeightBig(),
                ClearCache(),
                LineHeightBig(),
                Email(),
                LineHeightBig(),

              ],
            ),
          ),
        )
    );
  }

  Widget headIconArea(){
    return Container(
      color: gray_f4,
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Image.asset('images/ic_launcher_round.png',
        height: 80,
        width: 80,),
    );
  }

  Widget LineHeightBig(){
    return Container(
      color: gray_ea,
      width: double.infinity,
      height: 6,
    );
  }
  Widget LineHeightSmall(){
    return Container(
      color: gray_ea,
      width: double.infinity,
      height: 0.5,
    );
  }

  Widget Feedback(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(
          children: [
            Image.asset('images/icon_feedback.png',height: 14,width: 14,),
            SizedBox(width: 15,),
            Text(
              setting_feedback,
              style: TextStyle(
                  fontSize: 14,
                  color: gray_5),
            ),
          ],
        ),
      ),
    );
  }

  Widget Push(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(
          children: [
            Image.asset('images/icon_my_push.png',height: 14,width: 14,),
            SizedBox(width: 15,),
            Expanded(
              child: Text(
                setting_push,
                style: TextStyle(
                    fontSize: 14,
                    color: gray_5),
              ),
            ),
            FlutterSwitch(
                value: widget.status,
                width: 36,
                height: 20,
                padding: 1,
                borderRadius: 10,
                switchBorder: Border.all(
                  color: gray_ed,
                ),
                toggleSize: 18,
                inactiveToggleColor: gray_ed,
                activeColor: green_switch,
                inactiveColor: Colors.white,
                onToggle: (isEnable){
                  if(mounted){
                    setState(() {
                      widget.status = isEnable;
                    });
                  }
                  if(isEnable){
                    showToast('开启');
                  }else{
                    showToast('关闭');
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget Version(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(
          children: [
            Image.asset('images/icon_my_version.png',height: 14,width: 14,),
            SizedBox(width: 15,),
            Expanded(
              child: Text(
                setting_version,
                style: TextStyle(
                    fontSize: 14,
                    color: gray_5),
              ),
            ),
            checkVersion(),
          ],
        ),
      ),
    );
  }

  Widget checkVersion(){
    //强行返回有更新
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text(
            version_new,
            style: TextStyle(
                fontSize: 14,
                color: gray_5),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: red_dot,
            ),
          ),
        )
      ],
    );
  }

  Widget ClearCache(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(
          children: [
            Image.asset('images/icon_my_cash.png',height: 14,width: 14,),
            SizedBox(width: 15,),
            Expanded(
              child: Text(
                setting_cache,
                style: TextStyle(
                    fontSize: 14,
                    color: gray_5),
              ),
            ),
            Text(
              '0.00KB',
              style: TextStyle(
                  fontSize: 14,
                  color: gray_5),
            ),
          ],
        ),
      ),
    );
  }

  Widget Email(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(
          children: [
            Image.asset('images/icon_my_cash.png',height: 14,width: 14,),
            SizedBox(width: 15,),
            Expanded(
              child: Text(
                setting_email,
                style: TextStyle(
                    fontSize: 14,
                    color: gray_5),
              ),
            ),
            Text(
              setting_email_content,
              style: TextStyle(
                  fontSize: 14,
                  color: gray_5),
            ),
          ],
        ),
      ),
    );
  }
  //
}
