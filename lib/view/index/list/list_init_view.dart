import 'package:flutter/material.dart';

class ListInitView extends StatefulWidget {
  @override
  _ListInitViewState createState() => _ListInitViewState();
}

class _ListInitViewState extends State<ListInitView> {
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
