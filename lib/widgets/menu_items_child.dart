part of bottom_navigator_animation;

/// [MenuItemsChild] class takes [index],[menuItemsModel],[widgetWidth],[onTapCallback] parameters
/// We will Display each menu item in bottom navigation.
class MenuItemsChild extends StatefulWidget {
  const MenuItemsChild({
    required this.index,
    required this.menuItemsModel,
    required this.widgetWidth,
    required this.onTapCallback,
    Key? key,
  }) : super(key: key);
  final BottomBarItemsModel menuItemsModel;
  final Function(int index) onTapCallback;
  final double widgetWidth;
  final int index;

  @override
  _MenuItemsChildState createState() => _MenuItemsChildState();
}

class _MenuItemsChildState extends State<MenuItemsChild> with TickerProviderStateMixin {
  final ValueNotifier<double> _opacity = ValueNotifier(Dimens.maxOpacity);

  /// Below variables for animated icon.
  late AnimationController _animationControllerIcon;
  late Animation<Offset> _animationOffsetIcon;

  /// Below variables for dot icon.
  late AnimationController _animationControllerDot;
  late Animation<Offset> _animationOffsetDot;

  /// [reverseAnimation] Performing a reverse animation for item.
  void reverseAnimation() {
    _animationControllerIcon.reverse();
    _animationControllerDot.reverse();
    changeOpacity();
  }

  /// [forwardAnimation] Performing a forward animation for item.
  void forwardAnimation() {
    _animationControllerIcon.forward();
    _animationControllerDot.forward();
    changeOpacity();
  }

  void changeOpacity() {
    _opacity.value = (_opacity.value == Dimens.maxOpacity) ? Dimens.minOpacity : Dimens.maxOpacity;
  }

  @override
  void dispose() {
    _animationControllerIcon.dispose();
    _animationControllerDot.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initializeMembers();
    super.initState();
  }

  void _initializeMembers() {
    /// Here we are initializing animated icon animation
    _animationControllerIcon =
        AnimationController(vsync: this, duration: const Duration(milliseconds: Dimens.menuItemAnimationDuration));
    _animationOffsetIcon =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(_animationControllerIcon);

    /// Here we are initializing dot animation
    _animationControllerDot =
        AnimationController(vsync: this, duration: const Duration(milliseconds: Dimens.menuItemAnimationDuration));
    _animationOffsetDot =
        Tween<Offset>(begin: const Offset(0.0, 5.0), end: const Offset(0.0, 1.0)).animate(_animationControllerDot);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widgetWidth,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => _handleOnTap(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Stack(
                children: [
                  widget.menuItemsModel.icon,
                  SlideTransition(
                    position: _animationOffsetIcon,
                    child: widget.menuItemsModel.iconSelected,
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SlideTransition(
                      position: _animationOffsetDot,
                      child: SvgPicture.asset(
                        Images.icSvg,
                        package: Strings.bottomNavigatorAnimation,
                        width: Dimens.defaultDotSize,
                        height: Dimens.defaultDotSize,
                        color: widget.menuItemsModel.dotColor,
                      ),
                    ),
                  ),
                  ValueListenableBuilder<double>(
                    builder: (context, value, child) {
                      return AnimatedOpacity(
                        child: Text(
                          widget.menuItemsModel.title ?? '',
                          style: widget.menuItemsModel.titleStyle,
                        ),
                        opacity: value,
                        duration: const Duration(
                          milliseconds: Dimens.menuItemAnimationDuration,
                        ),
                      );
                    },
                    valueListenable: _opacity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnTap(BuildContext context) {
    widget.onTapCallback(widget.index);
  }
}
