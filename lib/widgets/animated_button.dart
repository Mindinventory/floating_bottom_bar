part of floating_bottom_bar;

/// [AnimatedButton] is docked button in center.
/// We have created animations using [AnimatedList].
class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.bottomBarCenterModel,
    Key? key,
  }) : super(key: key);

  final BottomBarCenterModel bottomBarCenterModel;

  @override
  State<AnimatedButton> createState() => AnimatedButtonState();
}

class AnimatedButtonState extends State<AnimatedButton> {
  final GlobalKey<_FloatingCenterButtonState> _floatingCenterButtonStateKey =
      GlobalKey<_FloatingCenterButtonState>();
  final GlobalKey<_CenterButtonsState> _centerButtonsState =
      GlobalKey<_CenterButtonsState>();
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  CircleButtonAnimationState _circleButtonAnimationState =
      CircleButtonAnimationState.idle;

  /// [eventBus] property is use to send or listen the events.
  static late EventBus eventBus;

  @override
  void initState() {
    _initializeEventBus();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _overlayState = Overlay.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: Dimens.bottomPaddingAnimatedButton),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: _handleOnTap,
          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: Dimens.animationDurationNormal),
            height: Dimens.buttonHeight,
            width: Dimens.closeButtonWidth,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.borderRadius),
              color: widget.bottomBarCenterModel.centerBackgroundColor,
            ),
            child: FloatingCenterButton(
              key: _floatingCenterButtonStateKey,
              child: widget.bottomBarCenterModel.centerIcon,
              onAnimationComplete: () {
                // We have added this animation listener.
                // Here we only manage the show overlay
                _handleOnTap();
              },
            ),
          ),
        ),
      ),
    );
  }

  /// [_initializeEventBus] Here we initialize the event bus for the events.
  void _initializeEventBus() {
    eventBus = EventBusImpl();
    eventBus.stream.listen(_listenEvent);
  }

  /// [_listenEvent] On tap of item this method will be execute and performs the animation.
  void _listenEvent(dynamic event) {
    if (event is ItemClickBusEvent) {
      _handleOnTap();
    }
  }

  void _handleOnTap() {
    if (_circleButtonAnimationState == CircleButtonAnimationState.running) {
      return;
    }
    _circleButtonAnimationState = CircleButtonAnimationState.running;

    Future.delayed(
        Duration(
            milliseconds: Dimens.animationDurationHigh *
                widget.bottomBarCenterModel.centerIconChild.length), () {
      _circleButtonAnimationState = CircleButtonAnimationState.idle;
    });

    if (_overlayEntry == null) {
      _showCenterButtons();
    } else {
      _removeCenterButtons();
    }

    _updateAnimation(_overlayEntry != null);
  }

  void _showCenterButtons() {
    RenderBox renderBox = _floatingCenterButtonStateKey.currentContext
        ?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(builder: (context) {
      return CenterButtons(
        bottomBarCenter: widget.bottomBarCenterModel,
        position: position,
        onTap: () {},
        key: _centerButtonsState,
      );
    });
    if (_overlayEntry != null) _overlayState?.insert(_overlayEntry!);
  }

  void _removeCenterButtons() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateAnimation(bool isOverlayVisible) {
    _floatingCenterButtonStateKey.currentState?._animationController
        .addListener(() {});
    (isOverlayVisible)
        ? _floatingCenterButtonStateKey.currentState?.forwardAnimation()
        : _floatingCenterButtonStateKey.currentState?.reverseAnimation();
  }
}
