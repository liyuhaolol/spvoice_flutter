import 'package:flutter/material.dart';
import 'package:spvoice_flutter/model/channel.dart';
import 'package:spvoice_flutter/page/list_page.dart';
import 'package:spvoice_flutter/res/colorlist.dart';
import 'package:spvoice_flutter/view/overscroll_behavior.dart';
import 'package:spvoice_flutter/view/tabbar/my_tabs.dart';

// ignore: must_be_immutable
class TabSuccessView extends StatefulWidget {
  List<Channel> channelList;

  TabSuccessView(this.channelList);

  @override
  _TabSuccessViewState createState() => _TabSuccessViewState();
}

class _TabSuccessViewState extends State<TabSuccessView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0,length: widget.channelList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: MyTabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelColor: splash_background_start,
                indicatorColor: splash_background_start,
                indicatorSize: MyTabBarIndicatorSize.fixed,
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                labelPadding: EdgeInsets.only(left: 6,right: 6),
                tabs: getTabView(widget.channelList),
                controller: _tabController,),
            ),
          ),
          Expanded(child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: TabBarView(
              children: getTabBarView(widget.channelList),
              controller: _tabController,),
          ),)
        ],
      ),
    );
  }
  List<Widget> getTabView(List<Channel> channelList){
    List<Widget> mList = [];
    channelList.forEach((element) {
      mList.add(MyTab(text: element.channelName,tabHeight: 30,));
    });
    return mList;
  }

  List<Widget> getTabBarView(List<Channel> channelList){
    List<Widget> mList = [];
    channelList.forEach((element) {
      mList.add(ListPage(element.channelId));
    });
    return mList;
  }
}
