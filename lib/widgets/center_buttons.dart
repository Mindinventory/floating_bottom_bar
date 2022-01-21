part of floating_bottom_bar;

class CenterButtons extends StatefulWidget {
  const CenterButtons({
    required this.bottomBarCenterModel,
    required this.onTap,
    required this.position,
    Key? key,
  }) : super(key: key);

  final BottomBarCenterModel bottomBarCenterModel;
  final VoidCallback onTap;
  final Offset position;

  @override
  State<CenterButtons> createState() => _CenterButtonsState();
}

class _CenterButtonsState extends State<CenterButtons> {
  final GlobalKey<AnimatedListState> _listOfWidgetsKey =
      GlobalKey<AnimatedListState>();
  final ValueNotifier<double> _opacity = ValueNotifier(Dimens.opacitySmall);
  final ValueNotifier<double> _height = ValueNotifier(Dimens.buttonHeight);
  late MediaQueryData _mediaQueryData;

  @override
  void didChangeDependencies() {
    _mediaQueryData = MediaQuery.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _removeItemFromAnimatedList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      builder: (context, value, child) {
        return Positioned(
          left: widget.position.dx,
          bottom: ((_mediaQueryData.size.height - Dimens.buttonHeight) -
              widget.position.dy),
          child: AnimatedOpacity(
            opacity: value,
            duration:
                const Duration(milliseconds: Dimens.animationDurationHigh),
            child: GestureDetector(
              onTap: () => widget.onTap(),
              child: ValueListenableBuilder<double>(
                builder: (context, value, child) {
                  return FittedBox(
                    child: AnimatedContainer(
                      width: Dimens.closeButtonWidth,
                      height: value,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimens.borderRadius),
                        color:
                            widget.bottomBarCenterModel.centerBackgroundColor,
                        // color: AppColors.lightPink
                      ),
                      curve: Curves.easeOut,
                      duration: Duration(
                          milliseconds: (value > Dimens.buttonHeight)
                              ? Dimens.animationDurationNormal
                              : (Dimens.animationDurationHigh *
                                  widget.bottomBarCenterModel.centerIconChild
                                      .length)),
                      child: AnimatedList(
                        key: _listOfWidgetsKey,
                        itemBuilder: (BuildContext context, index, animation) {
                          return CenterButtonChildAnimation(
                            animation: animation,
                            child: widget
                                .bottomBarCenterModel.centerIconChild[index],
                          );
                        },
                      ),
                    ),
                  );
                },
                valueListenable: _height,
              ),
            ),
          ),
        );
      },
      valueListenable: _opacity,
    );
  }

  /// [_insertItemInAnimatedList] method inserts element in [AnimatedList].
  void _insertItemInAnimatedList() {
    var future = Future(() {});
    for (var index = 0;
        index < widget.bottomBarCenterModel.centerIconChild.length;
        index++) {
      future = future.then((_) {
        return Future.delayed(
            const Duration(milliseconds: Dimens.animationDurationHigh), () {
          _listOfWidgetsKey.currentState?.insertItem(index);
        });
      });
    }
  }

  /// [_removeItemFromAnimatedList] method removes element from [AnimatedList].
  void _removeItemFromAnimatedList() {
    for (var index = widget.bottomBarCenterModel.centerIconChild.length - 1;
        index >= 0;
        index--) {
      _listOfWidgetsKey.currentState?.removeItem(
        index,
        (_, animation) {
          return CenterButtonChildAnimation(
            animation: animation,
            child: widget.bottomBarCenterModel.centerIconChild[index],
          );
        },
        duration: const Duration(milliseconds: Dimens.animationDurationHigh),
      );
    }
  }

  void _initialize() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _opacity.value = Dimens.opacityHigh;
      _height.value = Dimens.buttonHeight *
          widget.bottomBarCenterModel.centerIconChild.length;
      _insertItemInAnimatedList();
    });
  }
}
