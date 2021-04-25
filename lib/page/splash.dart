import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:spvoice_flutter/routers/routers.dart';
import 'package:spvoice_flutter/view/launchbackground.dart';

class PageSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            /*statusBarColor: Colors.white,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarDividerColor:Colors.white,*/
            statusBarBrightness: Brightness.dark,//iOS
            statusBarIconBrightness: Brightness.light,//Android
            systemNavigationBarIconBrightness: Brightness.light,//Android
        ),
        child: Stack(
          children: [
            LaunchBackground(),//启动图
            Skip(),
          ],
        ),
      ),
    );
  }
}


class Skip extends StatefulWidget {
  @override
  _SkipState createState() => _SkipState();
}

class _SkipState extends State<Skip> {
  Timer _timer;
  int _countdownTime = 3;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) {
          //给100毫秒延迟，让UI反应一下，避免感觉第一秒很短
          Future.delayed(
            Duration(
                milliseconds: 100),
                  (){
              startCountdownTimer();//启动计时器
            }
          );
          //startCountdownTimer();//启动计时器
    });
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) { });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  void startCountdownTimer(){
    const oneSec = const Duration(seconds: 1);
    var callback = (timer){
      if(_countdownTime == 1){
        _timer.cancel();
        goPageIndex(context);
      }else{
        setState(() {
          _countdownTime--;
        });
      }
    };
    //开始计时
    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 10,right: 20),
            child: GestureDetector(
              onTap: (){
                goPageIndex(context);
              },
              child: Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: skip_background,
                ),
                alignment: Alignment.center,
                child: Text(jumpLeft+'$_countdownTime'+jumpRight,
                  style: TextStyle(
                    fontSize: 14,
                    color: skip_text,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

void goPageIndex(BuildContext context){
  Navigator.pushNamedAndRemoveUntil(context, MyRouters.PAGE_INDEX, (route) => false);
}


