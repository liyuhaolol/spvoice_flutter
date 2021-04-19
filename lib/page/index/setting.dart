import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/view/commonheadbar.dart';

class PageSetting extends StatelessWidget {
  final arguments;
  String _title;

  PageSetting({this.arguments}){
    if(arguments != null){
      _title = arguments['title'];
    }else {
      _title = '';
    }
  }
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
          child: Column(
            children: [
              CommonHead(_title,hasLine: false,),
              headIconArea(),
            ],
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
}
