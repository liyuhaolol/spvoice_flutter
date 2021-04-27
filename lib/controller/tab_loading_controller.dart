import 'package:flutter/material.dart';
import 'package:spvoice_flutter/controller/base_view_controller.dart';
import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/view/list_loading_view.dart';

class TabRequsetController extends BaseViewController{
  List<Channel> _channelList = [];

  List<Channel> get channelList => _channelList;

  set channelList(List<Channel> value){
    _channelList.clear();
    _channelList.addAll(value);
  }

/*  void addChannelList(List<Channel> value){
    _channelList.addAll(value);
    notifyListeners();
  }*/
/*  void clearChannelList(){
    _channelList.clear();
    notifyListeners();
  }*/

  @override
  void setFailureView() {
    failure_view = ListFailureView();
  }

  @override
  void setLoadingView() {
    loading_view = ListLoadingView();
  }

  @override
  void setSuccessView() {
    success_view = ListSuccessView();
  }
}