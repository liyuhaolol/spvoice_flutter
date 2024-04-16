import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'my_tab_indicator.dart';


const double _kTabHeight = 46.0;
const double _kTextAndIconTabHeight = 72.0;

enum MyTabBarIndicatorSize {
  tab,
  label,
  fixed,
}

class MyTab extends StatelessWidget {
  const MyTab({
    Key? key,
    this.text = '',
    this.icon,
    this.iconMargin = const EdgeInsets.only(bottom: 10.0),
    this.child,
    this.tabHeight = _kTabHeight,
  }) : assert(text != null || child != null || icon != null),
        assert(child == null),
        super(key: key);

  final String text;

  final Widget? child;

  final Widget? icon;

  final double tabHeight;

  final EdgeInsetsGeometry iconMargin;

  Widget _buildLabelText() {
    return child ?? Text(text, softWrap: false, overflow: TextOverflow.fade);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    double height;
    Widget label;
    if (icon == null) {
      height = tabHeight;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      height = tabHeight;
      label = icon!;
    } else {
      height = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: iconMargin,
          ),
          _buildLabelText(),
        ],
      );
    }

    return SizedBox(
      height: height,
      child: Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text, defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
  }
}

class MyTabBar extends StatefulWidget implements PreferredSizeWidget {

  const MyTabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.indicatorWidth = 50,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback = false,
    this.onTap,
    this.physics,
  }) : assert(dragStartBehavior != null),
        assert(indicator != null || (indicatorWeight > 0.0)),
        assert(indicator != null || (indicatorPadding != null)),
        super(key: key);

  final List<Widget> tabs;

  final TabController? controller;

  final bool isScrollable;

  final Color? indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Decoration? indicator;

  final bool automaticIndicatorColorAdjustment;

  final MyTabBarIndicatorSize? indicatorSize;

  final Color? labelColor;

  final Color? unselectedLabelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final TextStyle? unselectedLabelStyle;

  final MaterialStateProperty<Color>? overlayColor;

  final DragStartBehavior? dragStartBehavior;

  final MouseCursor? mouseCursor;

  final bool enableFeedback;

  final ValueChanged<int>? onTap;

  final ScrollPhysics? physics;

  final double indicatorWidth;

  @override
  Size get preferredSize {
    for (final Widget item in tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if ((tab.text != null || tab.child != null) && tab.icon != null)
          return Size.fromHeight(_kTextAndIconTabHeight + indicatorWeight);
      }
    }
    return Size.fromHeight(_kTabHeight + indicatorWeight);
  }

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<MyTabBar> {
  ScrollController? _scrollController;
  TabController? _controller;
  _IndicatorPainter? _indicatorPainter;
  int _currentIndex = 0;
  double _tabStripWidth = 0;
  List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();

    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
  }

  Decoration get _indicator {
    if (widget.indicator != null)
      return widget.indicator!;
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    if (tabBarTheme.indicator != null)
      return tabBarTheme.indicator!;

    Color color = widget.indicatorColor ?? Theme.of(context).indicatorColor;

    if (widget.automaticIndicatorColorAdjustment && color.value == Material.of(context).color?.value)
      color = Colors.white;
    return MyUnderlineTabIndicator(
      borderSide: BorderSide(
        width: widget.indicatorWeight,
        color: color,
      ),
      indicatorSize: widget.indicatorSize!,
      indicatorWidth: widget.indicatorWidth,
    );
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final TabController newController = widget.controller ?? DefaultTabController.of(context);
    assert(() {
      return true;
    }());

    if (newController == _controller)
      return;

    if (_controllerIsValid) {
      _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
      _controller?.removeListener(_handleTabControllerTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller?.animation?.addListener(_handleTabControllerAnimationTick);
      _controller?.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _initIndicatorPainter() {
    _indicatorPainter = (!_controllerIsValid ? null : _IndicatorPainter(
      controller: _controller!,
      indicator: _indicator,
      indicatorSize: widget.indicatorSize ?? MyTabBarIndicatorSize.tab,
      indicatorPadding: widget.indicatorPadding,
      tabKeys: _tabKeys,
      old: _indicatorPainter,
    ))!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
    _initIndicatorPainter();
  }

  @override
  void didUpdateWidget(MyTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
      _initIndicatorPainter();
    } else if (widget.indicatorColor != oldWidget.indicatorColor ||
        widget.indicatorWeight != oldWidget.indicatorWeight ||
        widget.indicatorSize != oldWidget.indicatorSize ||
        widget.indicator != oldWidget.indicator) {
      _initIndicatorPainter();
    }

    if (widget.tabs.length > oldWidget.tabs.length) {
      final int delta = widget.tabs.length - oldWidget.tabs.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.tabs.length < oldWidget.tabs.length) {
      _tabKeys.removeRange(widget.tabs.length, oldWidget.tabs.length);
    }
  }

  @override
  void dispose() {
    _indicatorPainter?.dispose();
    if (_controllerIsValid) {
      _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
      _controller?.removeListener(_handleTabControllerTick);
    }
    //_controller = null;
    // We don't own the _controller Animation, so it's not disposed here.
    super.dispose();
  }

  int? get maxTabIndex => _indicatorPainter?.maxTabIndex;

  double _tabScrollOffset(int index, double viewportWidth, double minExtent, double maxExtent) {
    if (!widget.isScrollable)
      return 0.0;
    double? tabCenter = _indicatorPainter?.centerOf(index);
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        tabCenter = _tabStripWidth - tabCenter!;
        break;
      case TextDirection.ltr:
        break;
    }
    return (tabCenter! - viewportWidth / 2.0).clamp(minExtent, maxExtent);
  }

  double _tabCenteredScrollOffset(int index) {
    final ScrollPosition? position = _scrollController?.position;
    return _tabScrollOffset(index, position!.viewportDimension, position.minScrollExtent, position.maxScrollExtent);
  }

  double _initialScrollOffset(double viewportWidth, double minExtent, double maxExtent) {
    return _tabScrollOffset(_currentIndex, viewportWidth, minExtent, maxExtent);
  }

  void _scrollToCurrentIndex() {
    final double offset = _tabCenteredScrollOffset(_currentIndex);
    _scrollController?.animateTo(offset, duration: kTabScrollDuration, curve: Curves.ease);
  }

  void _scrollToControllerValue() {
    final double? leadingPosition = _currentIndex > 0 ? _tabCenteredScrollOffset(_currentIndex - 1) : null;
    final double middlePosition = _tabCenteredScrollOffset(_currentIndex);
    final double? trailingPosition = _currentIndex < maxTabIndex! ? _tabCenteredScrollOffset(_currentIndex + 1) : null;

    final double? index = _controller?.index.toDouble();
    final double? value = _controller?.animation?.value;
    double? offset;
    if (value == index! - 1.0)
      offset = leadingPosition ?? middlePosition;
    else if (value == index + 1.0)
      offset = trailingPosition ?? middlePosition;
    else if (value == index)
      offset = middlePosition;
    else if (value! < index)
      offset = leadingPosition == null ? middlePosition : lerpDouble(middlePosition, leadingPosition, index - value);
    else
      offset = trailingPosition == null ? middlePosition : lerpDouble(middlePosition, trailingPosition, value - index);

    _scrollController?.jumpTo(offset!);
  }

  void _handleTabControllerAnimationTick() {
    assert(mounted);
    if (!_controller!.indexIsChanging && widget.isScrollable) {
      // Sync the TabBar's scroll position with the TabBarView's PageView.
      _currentIndex = _controller!.index;
      _scrollToControllerValue();
    }
  }

  void _handleTabControllerTick() {
    if (_controller?.index != _currentIndex) {
      _currentIndex = _controller!.index;
      if (widget.isScrollable)
        _scrollToCurrentIndex();
    }
    setState(() {
      // Rebuild the tabs after a (potentially animated) index change
      // has completed.
    });
  }

  // Called each time layout completes.
  void _saveTabOffsets(List<double> tabOffsets, TextDirection textDirection, double width) {
    _tabStripWidth = width;
    _indicatorPainter?.saveTabOffsets(tabOffsets, textDirection);
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.tabs.length);
    _controller?.animateTo(index);
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  Widget _buildStyledTab(Widget child, bool selected, Animation<double> animation) {
    return _TabStyle(
      animation: animation,
      selected: selected,
      labelColor: widget.labelColor!,
      unselectedLabelColor: widget.unselectedLabelColor!,
      labelStyle: widget.labelStyle!,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (_controller?.length != widget.tabs.length) {
        throw FlutterError(
            "Controller's length property (${_controller?.length}) does not match the "
                "number of tabs (${widget.tabs.length}) present in TabBar's tabs property."
        );
      }
      return true;
    }());
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (_controller?.length == 0) {
      return Container(
        height: _kTabHeight + widget.indicatorWeight,
      );
    }

    final TabBarTheme tabBarTheme = TabBarTheme.of(context);

    final List<Widget> wrappedTabs = <Widget>[
      for (int i = 0; i < widget.tabs.length; i += 1)
        Center(
          heightFactor: 1.0,
          child: Padding(
            padding: widget.labelPadding ?? tabBarTheme.labelPadding ?? kTabLabelPadding,
            child: KeyedSubtree(
              key: _tabKeys[i],
              child: widget.tabs[i],
            ),
          ),
        )
    ];

    if (_controller != null) {
      final int previousIndex = _controller!.previousIndex;

      if (_controller!.indexIsChanging) {
        // The user tapped on a tab, the tab controller's animation is running.
        assert(_currentIndex != previousIndex);
        final Animation<double> animation = _ChangeAnimation(_controller!);
        wrappedTabs[_currentIndex] = _buildStyledTab(wrappedTabs[_currentIndex], true, animation);
        wrappedTabs[previousIndex] = _buildStyledTab(wrappedTabs[previousIndex], false, animation);
      } else {
        // The user is dragging the TabBarView's PageView left or right.
        final int tabIndex = _currentIndex;
        final Animation<double> centerAnimation = _DragAnimation(_controller!, tabIndex);
        wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], true, centerAnimation);
        if (_currentIndex > 0) {
          final int tabIndex = _currentIndex - 1;
          final Animation<double> previousAnimation = ReverseAnimation(_DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], false, previousAnimation);
        }
        if (_currentIndex < widget.tabs.length - 1) {
          final int tabIndex = _currentIndex + 1;
          final Animation<double> nextAnimation = ReverseAnimation(_DragAnimation(_controller!, tabIndex));
          wrappedTabs[tabIndex] = _buildStyledTab(wrappedTabs[tabIndex], false, nextAnimation);
        }
      }
    }

    // Add the tap handler to each tab. If the tab bar is not scrollable,
    // then give all of the tabs equal flexibility so that they each occupy
    // the same share of the tab bar's overall width.
    final int tabCount = widget.tabs.length;
    for (int index = 0; index < tabCount; index += 1) {
      wrappedTabs[index] = InkWell(
        mouseCursor: widget.mouseCursor ?? SystemMouseCursors.click,
        onTap: () { _handleTap(index); },
        enableFeedback: widget.enableFeedback ?? true,
        overlayColor: widget.overlayColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.indicatorWeight),
          child: Stack(
            children: <Widget>[
              wrappedTabs[index],
              Semantics(
                selected: index == _currentIndex,
                label: localizations.tabLabel(tabIndex: index + 1, tabCount: tabCount),
              ),
            ],
          ),
        ),
      );
      if (!widget.isScrollable)
        wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
    }

    Widget tabBar = CustomPaint(
      painter: _indicatorPainter,
      child: _TabStyle(
        animation: kAlwaysDismissedAnimation,
        selected: false,
        labelColor: widget.labelColor!,
        unselectedLabelColor: widget.unselectedLabelColor!,
        labelStyle: widget.labelStyle!,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        child: _TabLabelBar(
          onPerformLayout: _saveTabOffsets,
          children: wrappedTabs,
        ),
      ),
    );

    if (widget.isScrollable) {
      _scrollController ??= _TabBarScrollController(this);
      tabBar = SingleChildScrollView(
        dragStartBehavior: widget.dragStartBehavior!,
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: widget.physics,
        child: tabBar,
      );
    }

    return tabBar;
  }
}

class _IndicatorPainter extends CustomPainter {
  _IndicatorPainter({
    required this.controller,
    required this.indicator,
    required this.indicatorSize,
    required this.tabKeys,
    required _IndicatorPainter? old,
    required this.indicatorPadding,
  }) : super(repaint: controller.animation) {
    if (old != null)
      saveTabOffsets(old._currentTabOffsets!, old._currentTextDirection!);
  }

  final TabController controller;
  final Decoration indicator;
  final MyTabBarIndicatorSize indicatorSize;
  final EdgeInsetsGeometry indicatorPadding;
  final List<GlobalKey> tabKeys;

  // _currentTabOffsets and _currentTextDirection are set each time TabBar
  // layout is completed. These values can be null when TabBar contains no
  // tabs, since there are nothing to lay out.
  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  Rect? _currentRect;
  BoxPainter? _painter;
  bool _needsPaint = false;
  void markNeedsPaint() {
    _needsPaint = true;
  }

  void dispose() {
    _painter?.dispose();
  }

  void saveTabOffsets(List<double> tabOffsets, TextDirection textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }

  // _currentTabOffsets[index] is the offset of the start edge of the tab at index, and
  // _currentTabOffsets[_currentTabOffsets.length] is the end edge of the last tab.
  int get maxTabIndex => _currentTabOffsets!.length - 2;

  double centerOf(int tabIndex) {
    assert(_currentTabOffsets != null);
    assert(_currentTabOffsets!.isNotEmpty);
    assert(tabIndex >= 0);
    assert(tabIndex <= maxTabIndex);
    return (_currentTabOffsets![tabIndex] + _currentTabOffsets![tabIndex + 1]) / 2.0;
  }

  Rect indicatorRect(Size tabBarSize, int tabIndex) {
    assert(_currentTabOffsets != null);
    assert(_currentTextDirection != null);
    assert(_currentTabOffsets!.isNotEmpty);
    assert(tabIndex >= 0);
    assert(tabIndex <= maxTabIndex);
    double tabLeft = 0, tabRight = 0;
    switch (_currentTextDirection) {
      case TextDirection.rtl:
        tabLeft = _currentTabOffsets![tabIndex + 1];
        tabRight = _currentTabOffsets![tabIndex];
        break;
      case TextDirection.ltr:
        tabLeft = _currentTabOffsets![tabIndex];
        tabRight = _currentTabOffsets![tabIndex + 1];
        break;
      case null:
        break;
    }

    if (indicatorSize == MyTabBarIndicatorSize.label) {
      final double? tabWidth = tabKeys[tabIndex].currentContext?.size?.width;
      final double delta = ((tabRight - tabLeft) - tabWidth!) / 2.0;
      tabLeft += delta;
      tabRight -= delta;
    }

    final EdgeInsets insets = indicatorPadding.resolve(_currentTextDirection);
    final Rect rect = Rect.fromLTWH(tabLeft, 0.0, tabRight - tabLeft, tabBarSize.height);

    if (!(rect.size >= insets.collapsedSize)) {
      throw FlutterError(
          'indicatorPadding insets should be less than Tab Size\n'
              'Rect Size : ${rect.size}, Insets: ${insets.toString()}'
      );
    }
    return insets.deflateRect(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _needsPaint = false;
    _painter ??= indicator.createBoxPainter(markNeedsPaint);

    final double index = controller.index.toDouble();
    final double? value = controller.animation?.value;
    final bool ltr = index > value!;
    final int from = (ltr ? value.floor() : value.ceil()).clamp(0, maxTabIndex).toInt();
    final int to = (ltr ? from + 1 : from - 1).clamp(0, maxTabIndex).toInt();
    final Rect fromRect = indicatorRect(size, from);
    final Rect toRect = indicatorRect(size, to);
    _currentRect = Rect.lerp(fromRect, toRect, (value - from).abs())!;
    assert(_currentRect != null);

    final ImageConfiguration configuration = ImageConfiguration(
      size: _currentRect?.size,
      textDirection: _currentTextDirection,
    );
    _painter?.paint(canvas, _currentRect!.topLeft, configuration);
  }

  @override
  bool shouldRepaint(_IndicatorPainter old) {
    return _needsPaint
        || controller != old.controller
        || indicator != old.indicator
        || tabKeys.length != old.tabKeys.length
        || (!listEquals(_currentTabOffsets, old._currentTabOffsets))
        || _currentTextDirection != old._currentTextDirection;
  }
}

class _TabStyle extends AnimatedWidget {
  const _TabStyle({
    Key? key,
    required Animation<double> animation,
    required this.selected,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.labelStyle,
    required this.unselectedLabelStyle,
    required this.child,
  }) : super(key: key, listenable: animation);

  final TextStyle labelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool selected;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TabBarTheme tabBarTheme = TabBarTheme.of(context);
    final Animation<double> animation = listenable as Animation<double>;

    // To enable TextStyle.lerp(style1, style2, value), both styles must have
    // the same value of inherit. Force that to be inherit=true here.
    final TextStyle? defaultStyle = (labelStyle
        ?? tabBarTheme.labelStyle
        ?? themeData.primaryTextTheme.bodyLarge
    )?.copyWith(inherit: true);
    final TextStyle? defaultUnselectedStyle = (unselectedLabelStyle
        ?? tabBarTheme.unselectedLabelStyle
        ?? labelStyle
        ?? themeData.primaryTextTheme.bodyLarge
    )?.copyWith(inherit: true);
    final TextStyle? textStyle = selected
        ? TextStyle.lerp(defaultStyle, defaultUnselectedStyle, animation.value)
        : TextStyle.lerp(defaultUnselectedStyle, defaultStyle, animation.value);

    final Color? selectedColor = labelColor
        ?? tabBarTheme.labelColor
        ?? themeData.primaryTextTheme.bodyLarge?.color;
    final Color? unselectedColor = unselectedLabelColor
        ?? tabBarTheme.unselectedLabelColor
        ?? selectedColor?.withAlpha(0xB2); // 70% alpha
    final Color? color = selected
        ? Color.lerp(selectedColor, unselectedColor, animation.value)
        : Color.lerp(unselectedColor, selectedColor, animation.value);

    return DefaultTextStyle(
      style: textStyle!.copyWith(color: color),
      child: IconTheme.merge(
        data: IconThemeData(
          size: 24.0,
          color: color,
        ),
        child: child,
      ),
    );
  }
}

class _ChangeAnimation extends Animation<double> with AnimationWithParentMixin<double> {
  _ChangeAnimation(this.controller);

  final TabController controller;

  @override
  Animation<double> get parent => controller.animation!;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (controller.animation != null)
      super.removeStatusListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    if (controller.animation != null)
      super.removeListener(listener);
  }

  @override
  double get value => _indexChangeProgress(controller);
}

double _indexChangeProgress(TabController controller) {
  final double? controllerValue = controller.animation?.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();
  if (!controller.indexIsChanging)
    return (currentIndex - controllerValue!).abs().clamp(0.0, 1.0);

  // The TabController animation's value is changing from previousIndex to currentIndex.
  return (controllerValue! - currentIndex).abs() / (currentIndex - previousIndex).abs();
}

class _DragAnimation extends Animation<double> with AnimationWithParentMixin<double> {
  _DragAnimation(this.controller, this.index);

  final TabController controller;
  final int index;

  @override
  Animation<double> get parent => controller.animation!;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (controller.animation != null)
      super.removeStatusListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    if (controller.animation != null)
      super.removeListener(listener);
  }

  @override
  double get value {
    assert(!controller.indexIsChanging);
    final double controllerMaxValue = (controller.length - 1).toDouble();
    final double? controllerValue = controller.animation?.value.clamp(0.0, controllerMaxValue);
    return (controllerValue! - index.toDouble()).abs().clamp(0.0, 1.0);
  }
}

class _TabLabelBar extends Flex {
  _TabLabelBar({
    Key? key,
    List<Widget> children = const <Widget>[],
    required this.onPerformLayout,
  }) : super(
    key: key,
    children: children,
    direction: Axis.horizontal,
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    verticalDirection: VerticalDirection.down,
  );

  final _LayoutCallback onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}

typedef _LayoutCallback = void Function(List<double> xOffsets, TextDirection textDirection, double width);

class _TabLabelBarRenderer extends RenderFlex {
  _TabLabelBarRenderer({
    List<RenderBox>? children,
    required Axis direction,
    required MainAxisSize mainAxisSize,
    required MainAxisAlignment mainAxisAlignment,
    required CrossAxisAlignment crossAxisAlignment,
    required TextDirection textDirection,
    required VerticalDirection verticalDirection,
    required this.onPerformLayout,
  }) : super(
        children: children,
        direction: direction,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
      );

  _LayoutCallback onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();
    // xOffsets will contain childCount+1 values, giving the offsets of the
    // leading edge of the first tab as the first value, of the leading edge of
    // the each subsequent tab as each subsequent value, and of the trailing
    // edge of the last tab as the last value.
    RenderBox? child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData = child.parentData as FlexParentData;
      xOffsets.add(childParentData.offset.dx);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    assert(textDirection != null);
    switch (textDirection) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
        break;
      case TextDirection.ltr:
        xOffsets.add(size.width);
        break;
      case null:
        break;
    }
    onPerformLayout(xOffsets, textDirection!, size.width);
  }
}

class _TabBarScrollController extends ScrollController {
  _TabBarScrollController(this.tabBar);

  final _TabBarState tabBar;

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) {
    return _TabBarScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      tabBar: tabBar,
    );
  }
}

class _TabBarScrollPosition extends ScrollPositionWithSingleContext {
  _TabBarScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    required ScrollPosition? oldPosition,
    required this.tabBar,
  }) : super(
    physics: physics,
    context: context,
    initialPixels: null,
    oldPosition: oldPosition,
  );

  final _TabBarState tabBar;

  bool _initialViewportDimensionWasZero = false;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    bool result = true;
    if (_initialViewportDimensionWasZero != true) {
      // If the viewport never had a non-zero dimension, we just want to jump
      // to the initial scroll position to avoid strange scrolling effects in
      // release mode: In release mode, the viewport temporarily may have a
      // dimension of zero before the actual dimension is calculated. In that
      // scenario, setting the actual dimension would cause a strange scroll
      // effect without this guard because the super call below would starts a
      // ballistic scroll activity.
      _initialViewportDimensionWasZero = viewportDimension != 0.0;
      correctPixels(tabBar._initialScrollOffset(viewportDimension, minScrollExtent, maxScrollExtent));
      result = false;
    }
    return super.applyContentDimensions(minScrollExtent, maxScrollExtent) && result;
  }
}