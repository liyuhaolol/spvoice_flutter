import 'package:flutter/material.dart';
import 'package:spvoice_flutter/model/channel.dart';

// ignore: must_be_immutable
class ListSuccessView extends StatefulWidget {
  List<Channel> channelList;

  ListSuccessView(this.channelList);

  @override
  _ListSuccessViewState createState() => _ListSuccessViewState();
}

class _ListSuccessViewState extends State<ListSuccessView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.channelList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.blue,
            labelColor: Colors.black,
            tabs: getTabView(widget.channelList),
            controller: _tabController,),
          Expanded(child: TabBarView(
            children: getTabBarView(widget.channelList),
            controller: _tabController,),)
        ],
      ),
    );
  }
  List<Widget> getTabView(List<Channel> channelList){
    List<Widget> mList = [];
    channelList.forEach((element) {
      mList.add(Tab(text: element.channelName,));
    });
    return mList;
  }

  List<Widget> getTabBarView(List<Channel> channelList){
    List<Widget> mList = [];
    channelList.forEach((element) {
      mList.add(Container(
        color: Colors.amber,
      ));
    });
    return mList;
  }
}
