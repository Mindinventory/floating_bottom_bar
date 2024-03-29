part of '../animated_bottom_navigation_bar.dart';

/// [BottomBarCenterModel] class is model class for bottom menu.
/// It takes [icon], [iconSelected], [title], [dotColor], [titleStyle] as parameters.
class BottomBarCenterModel {
  const BottomBarCenterModel({
    required this.centerIcon,
    required this.centerIconChild,
    this.centerBackgroundColor = AppColors.cherryLightPink,
  });

  final FloatingCenterButton centerIcon;
  final Color centerBackgroundColor;
  final List<FloatingCenterButtonChild> centerIconChild;
}
