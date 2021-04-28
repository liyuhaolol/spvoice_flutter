import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/network/base_center.dart';
import 'package:spvoice_flutter/network/http_code.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/state/tab_request_data.dart';

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
              context.read<TabRequestData>().channelList = mList;
              context.read<TabRequestData>().state = ViewState.SUCCESS;
              break;
            default:
              context.read<TabRequestData>().state = ViewState.FAILURE;
              break;
          }
    } ,
            (e){
          context.read<TabRequestData>().state = ViewState.FAILURE;
    });
  }
}