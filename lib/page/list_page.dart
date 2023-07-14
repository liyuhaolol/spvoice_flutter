import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spvoice_flutter/data/static_data.dart';
import 'package:spvoice_flutter/model/list_item.dart';
import 'package:spvoice_flutter/network/http_code.dart';
import 'package:spvoice_flutter/network/httpconstants.dart';
import 'package:spvoice_flutter/network/requestcenter.dart';
import 'package:spvoice_flutter/state/main_list_request_data.dart';
import 'package:spvoice_flutter/state/request_view_state.dart';
import 'package:spvoice_flutter/view/index/list/list_init_view.dart';
import 'package:spvoice_flutter/view/news_view.dart';

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
    //super.build(context);
    return LayoutBuilder(
      builder: (_,constraints)=>ChangeNotifierProvider(
        create: (context)=> MainListRequestData(),
        child: SyncPage(widget.id,constraints.maxHeight),
      ),
    );
  }
}

class SyncPage extends StatefulWidget {
  int id;
  double viewPortHeight;
  SyncPage(this.id,this.viewPortHeight);

  @override
  _SyncPageState createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    super.initState();
    RequestCenter.getMainList(context, 1,widget.id, HttpConstants.PULL_DOWN);
  }

  @override
  Widget build(BuildContext context) {
    switch(context.watch<MainListRequestData>().state){
      case ViewState.INIT:
        return ListInitView();
      default:
        return MainListPage(widget.id,widget.viewPortHeight);
    }
  }
}


class MainListPage extends StatefulWidget {
  int id;
  double viewPortHeight;
  MainListPage(this.id,this.viewPortHeight);

  @override
  _MainListPageState createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: Provider.of<MainListRequestData>(context, listen: false).list.length >= StaticData.newsListSize,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        children: _buildList(context, widget.viewPortHeight),
      ));
  }

  List<Widget> _buildList(BuildContext context,double viewPortHeight){
    List<Widget> mList = [];
    if(Provider.of<MainListRequestData>(context, listen: false).bannerList != null && Provider.of<MainListRequestData>(context, listen: false).bannerList.length > 0){
      ///存在轮播图
      mList.add(SwiperView(context,Provider.of<MainListRequestData>(context, listen: false).bannerList));
    }
    Provider.of<MainListRequestData>(context, listen: false).list.forEach((element) {
      switch(element.contentTypeId){
        case News.EMPTY:
          mList.add(EmptyListItem(context,viewPortHeight));
          break;
        case News.TEXT:///纯文稿件
        case News.URL:///链接稿件
        mList.add(TextListItem(context,element));
          break;
        case News.SMALLIMG:///图文稿件
          mList.add(OnePicListItem(context,element));
          break;
        case News.BIGIMG:///图集稿件
          mList.add(BigPicListItem(context,element));
          break;
        case News.ATLASLEFT:///左三图稿件
          mList.add(ThreePicListItem(context, element));
          break;
        case News.VIDEO:///视频稿件
          mList.add(VideoListItem(context,element));
          break;
      }
    });
    return mList;
  }

  void _onRefresh() async{
    await RequestCenter.getMainList(context, 1,widget.id, HttpConstants.PULL_DOWN);
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _onLoading() async{
    int pageNum = Provider.of<MainListRequestData>(context, listen: false).pageNum +1;
    int code = await RequestCenter.getMainList(context, pageNum,widget.id, HttpConstants.PULL_UP);
    switch(code){
      case HttpCode.SUCCESS:
        if(Provider.of<MainListRequestData>(context, listen: false).pageNum >= Provider.of<MainListRequestData>(context, listen: false).pages){
          _refreshController.loadNoData();
        }else{
          _refreshController.loadComplete();
        }
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


