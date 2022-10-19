part of floating_bottom_bar;

/// [BottomBarItems] class is bottom menu item.
/// Each menu is [BottomBarItemsChild] class.
class BottomBarItems extends StatefulWidget {
  const BottomBarItems({required this.bottomBarItemsList, Key? key})
      : super(key: key);
  final List<BottomBarItemsModel> bottomBarItemsList;

  @override
  State<BottomBarItems> createState() => _BottomBarItemsState();
}

class _BottomBarItemsState extends State<BottomBarItems> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  int _currentIndex = 0;
  int _lastIndex = -1;
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
        child: Container(
          color: AppColors.white1,
          child: SizedBox(
            child: Row(
              children: _listBottomBarItemsChild,
            ),
            height: Dimens.containerHeight,
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
    int centerIndex = widget.bottomBarItemsList.length ~/ 2;
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

    widget.bottomBarItemsList[itemIndex].onTap?.call();

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
              as _BottomBarItemsChildState)
          .reverseAnimation();
    }
  }

  /// [_forwardAnimation] method set forward animation to menu item.
  void _forwardAnimation() {
    if (_listBottomBarItemsChild.isNotEmpty &&
        _listBottomBarItemsChild[_currentIndex].key is GlobalKey) {
      ((_listBottomBarItemsChild[_currentIndex].key as GlobalKey).currentState
              as _BottomBarItemsChildState)
          .forwardAnimation();
    }
  }

  /// [_setDefaultAnimation] method will select the first item and creates animation.
  void _setDefaultAnimation() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _forwardAnimation();
    });
  }
}
