import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';

class TabRequestData extends RequestViewState{
  late List<Channel> _channelList;

  List<Channel> get channelList => _channelList;

  set channelList(List<Channel> channelList) => _channelList = channelList;
}