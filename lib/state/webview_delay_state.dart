import 'package:flutter/material.dart';

enum WebState{
  INIT,
  COMPLATE,
}

class WebviewInitState extends ChangeNotifier{
  WebState _state = WebState.INIT;

  get state => _state;

  set state(WebState state){
    _state = state;
    notifyListeners();
  }
}