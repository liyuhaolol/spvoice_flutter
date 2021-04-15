
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';

class PageIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,//iOS
          statusBarIconBrightness: Brightness.dark,//Android
          systemNavigationBarIconBrightness: Brightness.dark,//Android
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(color: Colors.amber,
              child: Text('1'),),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                child: Row(
                  children: [
                    Expanded(//视频
                        child: GestureDetector(
                          onTap: (){
                            showToast('视频');
                          },
                          child: Container(
                            color: Colors.amber,
                            height: 50,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/icon_video.png',
                                  height: 24,
                                  width: 24,),
                                SizedBox(height: 3,),
                                Text('视频',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: gray_a7,
                                ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    Expanded(//视频
                        child: GestureDetector(
                          onTap: (){
                            showToast('视频');
                          },
                          child: Container(
                            color: Colors.amber,
                            height: 50,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/icon_video.png',
                                  height: 24,
                                  width: 24,),
                                SizedBox(height: 3,),
                                Text('视频',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray_a7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    Expanded(//视频
                        child: GestureDetector(
                          onTap: (){
                            showToast('视频');
                          },
                          child: Container(
                            color: Colors.amber,
                            height: 50,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/icon_video.png',
                                  height: 24,
                                  width: 24,),
                                SizedBox(height: 3,),
                                Text('视频',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray_a7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    Expanded(//视频
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/icon_video.png',
                                  height: 24,
                                  width: 24,),
                                SizedBox(height: 3,),
                                Text('视频',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray_a7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
