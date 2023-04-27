part of floating_bottom_bar;

class CenterButtons extends StatefulWidget {
  const CenterButtons({
    required this.bottomBarCenter,
    required this.onTap,
    required this.position,
    Key? key,
  }) : super(key: key);

  final BottomBarCenterModel bottomBarCenter;
  final VoidCallback onTap;
  final Offset position;

  @override
  State<CenterButtons> createState() => _CenterButtonsState();
}

bool isCloseBtnAdded = false;

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
                        color: widget.bottomBarCenter.centerBackgroundColor,
                        // color: AppColors.lightPink
                      ),
                      curve: Curves.easeOut,
                      duration: Duration(
                          milliseconds: (value > Dimens.buttonHeight)
                              ? Dimens.animationDurationNormal
                              : (Dimens.animationDurationHigh *
                                  widget
                                      .bottomBarCenter.centerIconChild.length)),
                      child: AnimatedList(
                        key: _listOfWidgetsKey,
                        itemBuilder: (BuildContext context, index, animation) {
                          return CenterButtonChildAnimation(
                            animation: animation,
                            child:
                                widget.bottomBarCenter.centerIconChild[index],
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

  Future<void> _addCloseButton() async {
    if (!isCloseBtnAdded) {
      widget.bottomBarCenter.centerIconChild.add(
        FloatingCenterButtonChild(
          child: const Icon(
            Icons.close,
            color: AppColors.white,
          ),
          onTap: () {},
        ),
      );
    }
    isCloseBtnAdded = true;
  }

  /// [_insertItemInAnimatedList] method inserts element in [AnimatedList].
  void _insertItemInAnimatedList() {
    var future = Future(() {});

    for (var index = 0;
        index < widget.bottomBarCenter.centerIconChild.length;
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
    for (var index = widget.bottomBarCenter.centerIconChild.length - 1;
        index >= 0;
        index--) {
      _listOfWidgetsKey.currentState?.removeItem(
        index,
        (_, animation) {
          return CenterButtonChildAnimation(
            animation: animation,
            child: widget.bottomBarCenter.centerIconChild[index],
          );
        },
        duration: const Duration(milliseconds: Dimens.animationDurationHigh),
      );
    }
  }

  void _initialize() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      _opacity.value = Dimens.opacityHigh;

      _addCloseButton().then((_) {
        _height.value =
            Dimens.buttonHeight * widget.bottomBarCenter.centerIconChild.length;
        _insertItemInAnimatedList();
      });
    });
  }
}
