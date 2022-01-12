part of bottom_navigator_animation;

/// [CenterButtonChildAnimation] class performs animation when center button clicks.
class CenterButtonChildAnimation extends StatefulWidget {
  /// [CenterButtonChildAnimation] class constructor takes [child],[animation] as a parameters.
  const CenterButtonChildAnimation({required this.child, required this.animation, Key? key}) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  _CenterButtonChildAnimationState createState() => _CenterButtonChildAnimationState();
}

class _CenterButtonChildAnimationState extends State<CenterButtonChildAnimation> {
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 2),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          curve: Curves.bounceOut,
          parent: widget.animation,
        ),
      ),
      child: FloatingCenterButton(
        child: widget.child,
      ),
    );
  }
}
