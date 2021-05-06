import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spvoice_flutter/network/http_code.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';
import 'package:spvoice_flutter/network/requestcenter.dart';
import 'package:spvoice_flutter/state/main_list_request_data.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/view/index/list/list_init_view.dart';
import 'package:spvoice_flutter/view/index/tab/tab_loading_view.dart';

///所有新闻列表页通用的list展示
class ListPage extends StatefulWidget {
  int id;
  ListPage(this.id);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context)=> MainListRequestData(),
      child: SyncPage(widget.id),
    );
  }
}

class SyncPage extends StatefulWidget {
  int id;
  SyncPage(this.id);

  @override
  _SyncPageState createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    super.initState();
    RequestCenter.getMainList(context, widget.id, HttpConstants.PULL_DOWN);
  }

  @override
  Widget build(BuildContext context) {
    switch(context.watch<MainListRequestData>().state){
      case ViewState.INIT:
        return ListInitView();
      default:
        return MainListPage(widget.id);
    }
  }
}


class MainListPage extends StatefulWidget {
  int id;
  MainListPage(this.id);

  @override
  _MainListPageState createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (context, index) => Card(child: Center(child: Text('${index+1}'))),
        itemExtent: 100.0,
        itemCount: context.watch<MainListRequestData>().list.length,
      ),
    );
  }

  void _onRefresh() async{
    await RequestCenter.getMainList(context, widget.id, HttpConstants.PULL_DOWN);
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _onLoading() async{
    int code = await RequestCenter.getMainList(context, widget.id, HttpConstants.PULL_UP);
    switch(code){
      case HttpCode.SUCCESS:
        _refreshController.loadComplete();
        break;
      case HttpCode.NO_DATA:
        _refreshController.loadNoData();
        break;
      default:
        _refreshController.loadFailed();
        break;
    }
  }
}


