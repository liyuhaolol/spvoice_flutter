import 'package:flutter/material.dart';

enum NewsState{
  LOADING,
  FINISH,
}

class NewsDetailState extends ChangeNotifier{
  NewsState _state = NewsState.LOADING;

  NewsState get state => _state;

  set state(NewsState state){
    _state = state;
    notifyListeners();
  }
}