library bottom_navigator_animation;

import 'dart:math' as math;

import 'package:bottom_navigator_animation/util/event_bus.dart';
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
  const AnimatedBottomNavigationBar({required this.menuCenterModel, required this.menuItems, Key? key})
      : super(key: key);
  final List<BottomBarItemsModel> menuItems;
  final BottomBarCenterModel menuCenterModel;

  @override
  _AnimatedBottomNavigationBarState createState() => _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _checkValidations();
    super.initState();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          MenuItems(
            menuItemsList: widget.menuItems,
          ),
          AnimatedButton(
            menuCenterModel: widget.menuCenterModel,
          ),
        ],
      ),
    );
  }

  /// Check tab bat items count is even.
  bool isEvenCount(int length) => length % 2 == 0;

  /// Check validations like maximum items exceed and item count is even.
  void _checkValidations() {
    assert(widget.menuItems.length <= Dimens.maximumItems, Strings.menuItemsMaximum);
    assert(isEvenCount(widget.menuItems.length), Strings.menuItemsMustBeEven);
  }
}
