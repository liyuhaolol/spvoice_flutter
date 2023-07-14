import 'package:flutter/material.dart';
import 'package:spvoice_flutter/res/colorlist.dart';

class CommonHead extends StatelessWidget {
  String _title;
  Color _lineColor = Colors.white;

  CommonHead(this._title,{bool hasLine = true}){
    if(hasLine){
      _lineColor = gray_ed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        height: 45,
        child: Stack(
          children: [
            Center(
              child: Text(
                _title,
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 1,
                color: _lineColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
