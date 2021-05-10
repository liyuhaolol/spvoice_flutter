import 'package:flutter/material.dart';
import 'package:spvoice_flutter/utils/toastutils.dart';

class CommonBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              width: 50,
              child: Center(
                child: Image.asset('images/icon_leftbtn.png',width: 11,height: 22,),
              ),
            ),
          ),
          Positioned(
              right: 15,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
              GestureDetector(
                onTap: (){
                  showToast('分享');
                },
                child: Container(
                  color: Colors.white,
                  width: 50,
                  child: Center(
                    child: Image.asset('images/icon_share.png',width: 24,height: 24,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  showToast('工具箱');
                },
                child: Container(
                  color: Colors.white,
                  width: 50,
                  child: Center(
                    child: Image.asset('images/icon_more.png',width: 24,height: 24,),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
