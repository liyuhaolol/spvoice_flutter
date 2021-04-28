import 'package:flutter/material.dart';
import 'package:spvoice_flutter/network/requestcenter.dart';

class ListLoadingView extends StatefulWidget {
  @override
  _ListLoadingViewState createState() => _ListLoadingViewState();
}

class _ListLoadingViewState extends State<ListLoadingView> {
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
