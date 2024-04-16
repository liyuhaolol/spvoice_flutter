import 'package:flutter/material.dart';

class OverScrollBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    switch(getPlatform(context)){
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      ///去除横移动画
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: false,
          showTrailing: false,
          axisDirection: details.direction,
          color: Theme.of(context).primaryColor,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
    }
  }
}