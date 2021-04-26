import 'package:flutter/material.dart';
import 'package:spvoice_flutter/controller/base_view_controller.dart';
import 'package:spvoice_flutter/view/list_loading_view.dart';

class TabRequsetController extends BaseViewController{

  @override
  void setFailureView() {
    failure_view = listFailureView();
  }

  @override
  void setLoadingView() {
    loading_view = ListLoadingView();
  }

  @override
  void setSuccessView() {
    success_view = ListLoadingView();
  }
}