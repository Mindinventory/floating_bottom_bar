part of '../animated_bottom_navigation_bar.dart';

/// [BottomBarItems] class is bottom menu item.
/// Each menu is [BottomBarItemsChild] class.
class BottomBarItems extends StatefulWidget {
  const BottomBarItems({
    required this.bottomBarItemsList,
    this.barColor = Colors.white,
    this.barGradient,
    this.controller,
    Key? key,
  }) : super(key: key);
  final List<BottomBarItem> bottomBarItemsList;
  final Color barColor;
  final Gradient? barGradient;
  final FloatingBottomBarController? controller;

  @override
  State<BottomBarItems> createState() => _BottomBarItemsState();
}

class _BottomBarItemsState extends State<BottomBarItems> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  int _currentIndex = 0;
  int _lastIndex = -1;
  late int centerIndex;
  final List<Widget> _listBottomBarItemsChild = [];

  @override
  void didChangeDependencies() {
    geometryListenable = Scaffold.geometryOf(context);
    _generateBottomBarItems();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _setDefaultAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: PhysicalShape(
        elevation: Dimens.elevation,
        color: AppColors.transparent,
        clipper: CircularNotchedAndCorneredRectangleClipper(
          shape: CircularNotchedAndCorneredRectangle(
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.center,
            cornerRadius: Dimens.containerCornerCurve,
          ),
          geometry: geometryListenable,
          notchMargin: Dimens.notchMargin,
        ),
        clipBehavior: Clip.antiAlias,
        child: widget.barGradient == null
            ? Container(
                color: widget.barColor,
                child: SizedBox(
                  height: Dimens.containerHeight,
                  child: Row(
                    children: _listBottomBarItemsChild,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(gradient: widget.barGradient),
                child: SizedBox(
                  height: Dimens.containerHeight,
                  child: Row(
                    children: _listBottomBarItemsChild,
                  ),
                ),
              ),
      ),
    );
  }

  /// [_generateBottomBarItems]
  _generateBottomBarItems() {
    double width = MediaQuery.of(context).size.width /
        (widget.bottomBarItemsList.length + 1);
    _listBottomBarItemsChild.clear();
    widget.bottomBarItemsList.asMap().forEach((itemIndex, value) {
      if (centerIndex == itemIndex) {
        _listBottomBarItemsChild.add(
          SizedBox(
            width: width,
          ),
        );
      }
      _listBottomBarItemsChild.add(
        BottomBarItemsChild(
          index: _listBottomBarItemsChild.length,
          key: GlobalKey(),
          widgetWidth: width,
          bottomBarItemsModel: value,
          onTapCallback: (index) => _handleOnTapCallback(index, itemIndex),
        ),
      );
    });
  }

  /// Here, we handle the callback for on tap item.
  /// _currentIndex position item performs the forward animation.
  /// _lastIndex position item performs the reverse animation.
  void _handleOnTapCallback(int index, int itemIndex) {
    if (_currentIndex == index) return;

    isCloseBtnAdded = false;
    widget.bottomBarItemsList[itemIndex].onTap?.call(itemIndex);

    _lastIndex = _currentIndex;
    _currentIndex = index;

    _reverseAnimation();
    _forwardAnimation();
  }

  /// [_reverseAnimation] method set reverse animation to last menu item.
  void _reverseAnimation() {
    if (_listBottomBarItemsChild.isNotEmpty &&
        _listBottomBarItemsChild[_lastIndex].key is GlobalKey) {
      ((_listBottomBarItemsChild[_lastIndex].key as GlobalKey).currentState
              as BottomBarItemsChildState)
          .reverseAnimation();
    }
  }

  /// [_forwardAnimation] method set forward animation to menu item.
  void _forwardAnimation() {
    if (_listBottomBarItemsChild.isNotEmpty &&
        _listBottomBarItemsChild[_currentIndex].key is GlobalKey) {
      ((_listBottomBarItemsChild[_currentIndex].key as GlobalKey).currentState
              as BottomBarItemsChildState)
          .forwardAnimation();
    }
  }

  /// [_setDefaultAnimation] method will select the first item and creates animation.
  void _setDefaultAnimation() {
    centerIndex = widget.bottomBarItemsList.length ~/ 2;
    _currentIndex = (centerIndex > (widget.controller?.initialIndex ?? 0))
        ? (widget.controller?.initialIndex ?? 0)
        : (widget.controller?.initialIndex ?? 0) + 1;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _forwardAnimation();
    });
  }
}
