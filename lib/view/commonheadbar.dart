import 'package:flutter/material.dart';
import 'package:spvoice_flutter/res/colorlist.dart';

class CommonHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        height: 44,
        child: Stack(
          children: [
            Center(
              child: Text(
                '设置',
                style: TextStyle(fontSize: 18,color: gray_5),),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                width: 50,
                height: double.infinity,
                padding: EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                child: Image.asset('images/icon_leftbtn.png',width: 11,height: 22,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
