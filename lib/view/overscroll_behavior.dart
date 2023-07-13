import 'package:flutter/material.dart';

class OverScrollBehavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    switch(getPlatform(context)){
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        ///去除横移动画
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: false,
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).primaryColor,
        );
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
        break;
    }
  }
}