part of floating_bottom_bar;

class FloatingCenterButtonChild extends StatelessWidget {
  const FloatingCenterButtonChild({required this.child, this.onTap, Key? key})
      : super(key: key);
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnimatedButtonState.eventBus.sendEvent(ItemClickBusEvent());
        onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(Dimens.buttonContentPadding),
        child: CircleAvatar(
          backgroundColor:
              AppColors.white.withOpacity(Dimens.buttonContentOpacityValue),
          radius: Dimens.circularButtonContentRadius,
          child: child,
        ),
      ),
    );
  }
}
