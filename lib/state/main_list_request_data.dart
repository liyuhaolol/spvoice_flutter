import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';

class MainListRequestData extends RequestViewState{
  List<News> bannerList = [];
  List<News> list = [];
  int pageNum = 0;
  int pages = 0;
  int total = 0;

}