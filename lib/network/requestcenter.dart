import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/network/base_center.dart';
import 'package:spvoice_flutter/network/http_code.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';
import 'package:spvoice_flutter/state/main_list_request_data.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/state/tab_request_data.dart';

import '../utils/token.dart';

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

  ///得到新闻列表
  static Future<int> getMainList(BuildContext context,int channelId,int pullType) async{
    int pullCode = 0;
    await getRequest(HttpConstants.getPullUrl(pullType), (_,body){
      Map result = json.decode(body);
      switch(result['code']){
        case HttpCode.SUCCESS:
          if(result['info'] != null){
            ListItem mData = ListItem.fromJson(result['info']);
            if(pullType == HttpConstants.PULL_DOWN){///如果是下拉
              context.read<MainListRequestData>().bannerList = mData.bannerList;
              context.read<MainListRequestData>().list = mData.articleList.list;
            }else{
              context.read<MainListRequestData>().list.addAll(mData.articleList.list);
            }
            context.read<MainListRequestData>().pageNum = mData.articleList.pageNum;
            context.read<MainListRequestData>().pages = mData.articleList.pages;
            context.read<MainListRequestData>().total = mData.articleList.total;
          }
          context.read<MainListRequestData>().state = ViewState.SUCCESS;
          pullCode = HttpCode.SUCCESS;
          break;
        case HttpCode.NO_DATA:
          if(pullType == HttpConstants.PULL_DOWN){///如果是下拉
            List<News> mList = [];
            mList.add(News(contentTypeId: News.EMPTY));
            context.read<MainListRequestData>().list = mList;
            if(context.read<MainListRequestData>().bannerList != null){
              context.read<MainListRequestData>().bannerList.clear();
            }
            context.read<MainListRequestData>().pageNum = 0;
            context.read<MainListRequestData>().pages = 0;
            context.read<MainListRequestData>().total = 0;
          }
          context.read<MainListRequestData>().state = ViewState.SUCCESS;
          pullCode = HttpCode.NO_DATA;
          break;
        default:
          if(pullType == HttpConstants.PULL_DOWN
              && context.read<MainListRequestData>().list == null){///如果是下拉
            List<News> mList = [];
            mList.add(News(contentTypeId: News.EMPTY));
            context.read<MainListRequestData>().list = mList;
            if(context.read<MainListRequestData>().bannerList != null){
              context.read<MainListRequestData>().bannerList.clear();
            }
          }
          context.read<MainListRequestData>().state = ViewState.FAILURE;
          pullCode = HttpCode.SERVER_ERROR;
          break;
      }
    }, (e){
      context.read<MainListRequestData>().state = ViewState.FAILURE;
      pullCode = HttpCode.SERVER_ERROR;
    },
        headers:await generateHeader(context),
        bodyParams: {
      'channelId':'$channelId'
    });
    return pullCode;
  }
  
  static Future<Map<String, String>> generateHeader(BuildContext context) async {
    Map<String,String> headers = Map();
    headers['appKey'] = 'TY71007273147079';
    String json = "{\"siteId\":\"710072731470794752\",\"platform\":\"Android\",\"userId\":\"123456789\"}";
    String token = await NtpToken.getNtpToken(
    json,
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWYWJvPKKbp5rabEIsV98ubfWeahj04O5uTSzQNDvBAZ7/FzwioILyjpSqE8GCCI8T0MCWd7WW6OWn2aMClvosUYq+BnBt7rH3d8yRwuraUDzpo0cah8amyrQBJ6ky42BPXbcloV12ogjG29GlQTPVJ2gCiKSYedOcgN2sb1u7PQIDAQAB"
    );
    headers['appToken'] = token;
    return headers;
  }
  
  ///测试正式服接口
  static void getTab2(BuildContext context) async{
    getRequest(
        HttpConstants.GET_NEWS_CHANNEL, (_,body){}, (e) {},
    headers: await generateHeader(context));
  }
}