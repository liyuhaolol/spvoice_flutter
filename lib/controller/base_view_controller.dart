import 'package:flutter/material.dart';

enum ViewState{
  INIT,
  LOADING,
  SUCCESS,
  FAILURE
}

abstract class BaseViewController extends ChangeNotifier{
  Widget loading_view,success_view,failure_view;
  ViewState _state = ViewState.LOADING;

  BaseViewController(){
    setLoadingView();
    setFailureView();
    setSuccessView();
  }

  void setLoadState(ViewState state){
    this._state = state;
    notifyListeners();
  }

  Widget getView(){
    switch(_state){
      case ViewState.INIT:
        break;
      case ViewState.LOADING:
        return loading_view;
        break;
      case ViewState.SUCCESS:
        return success_view;
        break;
      case ViewState.FAILURE:
        return failure_view;
        break;
    }
  }

  void setLoadingView();

  void setSuccessView();

  void setFailureView();


}