import 'package:flutter/material.dart';
import 'package:spvoice_flutter/network/requestcenter.dart';

class TabLoadingView extends StatefulWidget {
  @override
  _TabLoadingViewState createState() => _TabLoadingViewState();
}

class _TabLoadingViewState extends State<TabLoadingView> {
  @override
  void initState() {
    super.initState();
    RequestCenter.getTab(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.asset('images/newslist_emty.png',
        fit: BoxFit.fitWidth,
        alignment: AlignmentDirectional.topStart,),
    );
  }
}
