library floating_bottom_bar;

import 'dart:math' as math;

import 'package:floating_bottom_bar/util/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

import 'constants/enums.dart';

part 'constants/colors.dart';

part 'constants/dimens.dart';

part 'constants/images.dart';

part 'constants/strings.dart';

part 'curved_notch/circular_notch_and_corner_clipper.dart';

part 'curved_notch/circular_notched_and_cornered_shape.dart';

part 'models/bottom_bar_item_model.dart';

part 'models/bottom_bar_center_model.dart';

part 'widgets/animated_button.dart';

part 'widgets/center_button_child_animation.dart';

part 'widgets/center_buttons.dart';

part 'widgets/floating_center_button.dart';

part 'widgets/floating_center_button_child.dart';

part 'widgets/menu_items.dart';

part 'widgets/menu_items_child.dart';

class AnimatedBottomNavigationBar extends StatefulWidget {
  const AnimatedBottomNavigationBar({
    required this.bottomBarCenterModel,
    required this.bottomBar,
    this.barColor = Colors.white,
    this.barGradient,
    this.controller,
    Key? key,
  }) : super(key: key);
  final List<BottomBarItem> bottomBar;
  final BottomBarCenterModel bottomBarCenterModel;
  final Color barColor;
  final Gradient? barGradient;
  final FloatingBottomBarController? controller;

  @override
  AnimatedBottomNavigationBarState createState() =>
      AnimatedBottomNavigationBarState();
}

class AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _checkValidations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          BottomBarItems(
            barColor: widget.barColor,
            bottomBarItemsList: widget.bottomBar,
            barGradient: widget.barGradient,
            controller: widget.controller,
          ),
          AnimatedButton(
            bottomBarCenterModel: widget.bottomBarCenterModel,
          ),
        ],
      ),
    );
  }

  /// Check tab bat items count is even.
  bool isEvenCount(int length) => length % 2 == 0;

  /// Check validations like maximum items exceed and item count is even.
  void _checkValidations() {
    assert(widget.bottomBar.length <= Dimens.maximumItems,
        Strings.menuItemsMaximum);
    assert(isEvenCount(widget.bottomBar.length), Strings.menuItemsMustBeEven);
  }
}

class FloatingBottomBarController {
  int initialIndex;

  FloatingBottomBarController({this.initialIndex = 0});
}
