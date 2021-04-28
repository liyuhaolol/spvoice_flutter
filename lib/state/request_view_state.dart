import 'package:flutter/material.dart';

enum ViewState{
  INIT,
  LOADING,
  SUCCESS,
  FAILURE
}

class RequestViewState extends ChangeNotifier{
  ViewState _state = ViewState.INIT;

  get state => _state;

  set state(ViewState state){
    _state = state;
    notifyListeners();
  }
}