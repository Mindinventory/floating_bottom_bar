part of floating_bottom_bar;

/// [FloatingCenterButton] class shows a
class FloatingCenterButton extends StatefulWidget {
  const FloatingCenterButton(
      {required this.child, this.onAnimationComplete, Key? key})
      : super(key: key);
  final Widget child;
  final VoidCallback? onAnimationComplete;

  @override
  State<FloatingCenterButton> createState() => _FloatingCenterButtonState();
}

class _FloatingCenterButtonState extends State<FloatingCenterButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        child: widget.child,
      ),
    );
  }

  void _initialize() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: Dimens.animationDurationHigh),
      vsync: this,
      upperBound: 0.5,
    );
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  void reverseAnimation() {
    _animationController.reverse(from: .5);
  }

  void forwardAnimation() {
    _animationController.forward(from: .0);
  }
}
