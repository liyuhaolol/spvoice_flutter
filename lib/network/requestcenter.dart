import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/controller/base_view_controller.dart';
import 'package:spvoice_flutter/controller/tab_loading_controller.dart';
import 'package:spvoice_flutter/network/base_center.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';

class RequestCenter {

  ///得到栏目列表
  static void getTab(BuildContext context){
    getRequest(
        HttpConstants.GET_TAB,(_,body){} ,(e){
          context.read<TabRequsetController>().setLoadState(ViewState.FAILURE);
    },
    bodyParams: {
          "id" : "1",
      "name" : "测试"
    });
  }
}