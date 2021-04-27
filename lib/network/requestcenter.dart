import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/controller/base_view_controller.dart';
import 'package:spvoice_flutter/controller/tab_loading_controller.dart';
import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/network/base_center.dart';
import 'package:spvoice_flutter/network/http_code.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';

class RequestCenter {

  ///得到栏目列表
  static void getTab(BuildContext context){
    getRequest(
        HttpConstants.GET_TAB,
            (_,body){
          Map result = json.decode(body);
          switch(result['code']){
            case HttpCode.SUCCESS:
              List<Channel> mList = [];
              if(result['info'] != null){
                result['info'].forEach((v){
                  mList.add(Channel.fromJson(v));
                });
              }
              context.read<TabRequsetController>().channelList = mList;
              context.read<TabRequsetController>().setLoadState(ViewState.SUCCESS);
              break;
            default:
              context.read<TabRequsetController>().setLoadState(ViewState.FAILURE);
              break;
          }
    } ,
            (e){
          context.read<TabRequsetController>().setLoadState(ViewState.FAILURE);
    });
  }
}