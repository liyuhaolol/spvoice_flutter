import 'package:flutter/material.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/res/stringlist.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/state/tab_request_data.dart';

class TabFailureView extends StatelessWidget {
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
              context.read<TabRequestData>().state = ViewState.INIT;
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
