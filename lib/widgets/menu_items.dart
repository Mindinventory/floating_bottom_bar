part of bottom_navigator_animation;

/// [MenuItems] class is bottom menu item.
/// Each menu is [MenuItemsChild] class.
class MenuItems extends StatefulWidget {
  const MenuItems({required this.menuItemsList, Key? key}) : super(key: key);
  final List<BottomBarItemsModel> menuItemsList;

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  int _currentIndex = 0;
  int _lastIndex = -1;
  final List<Widget> _listMenuItemsChild = [];

  @override
  void didChangeDependencies() {
    geometryListenable = Scaffold.geometryOf(context);
    _generateMenuItems();
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
              children: _listMenuItemsChild,
            ),
            height: Dimens.containerHeight,
          ),
        ),
      ),
    );
  }

  /// [_generateMenuItems]
  _generateMenuItems() {
    double width = MediaQuery.of(context).size.width / (widget.menuItemsList.length + 1);
    _listMenuItemsChild.clear();
    int centerIndex = widget.menuItemsList.length ~/ 2;
    widget.menuItemsList.asMap().forEach((itemIndex, value) {
      if (centerIndex == itemIndex) {
        _listMenuItemsChild.add(
          SizedBox(
            width: width,
          ),
        );
      }
      _listMenuItemsChild.add(
        MenuItemsChild(
          index: _listMenuItemsChild.length,
          key: GlobalKey(),
          widgetWidth: width,
          menuItemsModel: value,
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

    widget.menuItemsList[index].onTap?.call();

    _lastIndex = _currentIndex;
    _currentIndex = index;

    _reverseAnimation();
    _forwardAnimation();
  }

  /// [_reverseAnimation] method set reverse animation to last menu item.
  void _reverseAnimation() {
    if (_listMenuItemsChild.isNotEmpty && _listMenuItemsChild[_lastIndex].key is GlobalKey) {
      ((_listMenuItemsChild[_lastIndex].key as GlobalKey).currentState as _MenuItemsChildState).reverseAnimation();
    }
  }

  /// [_forwardAnimation] method set forward animation to menu item.
  void _forwardAnimation() {
    if (_listMenuItemsChild.isNotEmpty && _listMenuItemsChild[_currentIndex].key is GlobalKey) {
      ((_listMenuItemsChild[_currentIndex].key as GlobalKey).currentState as _MenuItemsChildState).forwardAnimation();
    }
  }

  /// [_setDefaultAnimation] method will select the first item and creates animation.
  void _setDefaultAnimation() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _forwardAnimation();
    });
  }
}
