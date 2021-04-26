import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/controller/base_view_controller.dart';
import 'package:spvoice_flutter/controller/tab_loading_controller.dart';
import 'package:spvoice_flutter/network/RequestCenter.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';

class ListLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){
          context.read<TabRequsetController>().setLoadState(ViewState.FAILURE);
        },
        child: Text('点击加载失败'),
      ),
    );
  }
}

class listFailureView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/icon_nocontent.png',
          height: 90,
          width: 100,),
          SizedBox(height: 20,),
          Text(tab_request_fail,
          style: TextStyle(
            fontSize: 14,
            color: gray_e5
          ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              context.read<TabRequsetController>().setLoadState(ViewState.LOADING);
              RequestCenter.getTab(context);
            },
            child: Container(
              width: 66,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(width: 1,color: splash_background_start),
              ),
              child: Text(refresh,
              style: TextStyle(
                fontSize: 14,
                color: splash_background_start
              ),),
            ),
          ),
        ],
      ),
    );
  }

}
