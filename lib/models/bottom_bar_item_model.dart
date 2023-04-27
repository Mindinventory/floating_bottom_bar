part of floating_bottom_bar;

/// [BottomBarItem] class is model class for bottom menu.
/// It takes [icon], [iconSelected], [title], [dotColor], [titleStyle] as parameters.
class BottomBarItem {
  const BottomBarItem(
      {required this.icon,
      required this.iconSelected,
      this.title,
      this.dotColor = AppColors.black,
      this.titleStyle,
      this.onTap});

  final Widget icon;
  final Widget iconSelected;
  final String? title;
  final Color dotColor;
  final TextStyle? titleStyle;
  final Function(int value)? onTap;
}
