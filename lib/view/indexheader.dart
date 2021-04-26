import 'package:flutter/material.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';

class MainTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Row(
          children: [
            Image.asset(
              'images/icon_logo.png',
              height: 26,
              width: 100,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15,),
                child: GestureDetector(
                  onTap: (){
                    showToast('搜索');
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(width: 1,color: gray_ea),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'images/icon_search.png',
                      height: 17,
                      width: 17,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
