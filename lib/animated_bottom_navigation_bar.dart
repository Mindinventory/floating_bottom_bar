library bottom_navigator_animation;

import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';
import 'package:bottom_navigator_animation/constants/enums.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constants/dimensions.dart';
import 'constants/enums.dart';

part 'curved_notch/circular_notch_and_corner_clipper.dart';

part 'curved_notch/circular_notched_and_cornered_shape.dart';

part 'constants/colours.dart';

class BottomNavBarBody extends StatefulWidget {
  const BottomNavBarBody({Key? key}) : super(key: key);

  @override
  _BottomNavBarBodyState createState() => _BottomNavBarBodyState();
}

class _BottomNavBarBodyState extends State<BottomNavBarBody> with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  bool circleButtonToggle = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: PhysicalShape(
              elevation: Dimensions.elevation,
              color: ColoursAssets.transparent,
              clipper: CircularNotchedAndCorneredRectangleClipper(
                shape: CircularNotchedAndCorneredRectangle(
                  notchSmoothness: NotchSmoothness.defaultEdge,
                  gapLocation: GapLocation.center,
                  leftCornerRadius: Dimensions.containerCornerCurve,
                  rightCornerRadius: Dimensions.containerCornerCurve,
                ),
                geometry: geometryListenable,
                notchMargin: Dimensions.notchMargin,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Material(
                color: ColoursAssets.white1,
                child: SafeArea(
                  child: SizedBox(
                    child: Row(
                      children: [
                        _IconButton(
                          icon: Icons.ten_k_outlined,
                          onPress: () {},
                          padding: Dimensions.iconsLeftPadding,
                        ),
                        _IconButton(
                          icon: Icons.ten_k_outlined,
                          onPress: () {},
                          padding: Dimensions.iconsLeftPadding,
                        ),
                        _IconButton(
                          icon: Icons.ten_k_outlined,
                          onPress: () {},
                          padding: Dimensions.iconsLeftPadding1,
                        ),
                        _IconButton(
                          icon: Icons.ten_k_outlined,
                          onPress: () {},
                          padding: Dimensions.iconsLeftPadding,
                        ),
                      ],
                    ),
                    height: Dimensions.containerHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedButton(
          circleToggleCallBack: (bool value) {
            circleButtonToggle = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.circleToggleCallBack,
    Key? key,
  }) : super(key: key);
  final Function(bool) circleToggleCallBack;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  bool circleButtonState = false;
  final GlobalKey<AnimatedListState> _listOfWidgetsKey = GlobalKey<AnimatedListState>();
  final List<IconData> _listOfIcons = [
    Icons.home_filled,
    Icons.home_filled,
    Icons.home_filled,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.bottomPaddingAnimatedButton),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            circleButtonState = !circleButtonState;
            setState(() {});
            widget.circleToggleCallBack.call(circleButtonState);
            _loadItems();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: (!circleButtonState) ? Dimensions.closeButtonHeight : Dimensions.openButtonHeight,
            width: Dimensions.closeButtonWidth,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.borderRadius),
              color: ColoursAssets.cherryLightPink,
            ),
            child: Column(
              children: [
                circleButtonState
                    ? Expanded(
                        child: Center(
                          child: AnimatedList(
                            key: _listOfWidgetsKey,
                            itemBuilder: (BuildContext context, index, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 2),
                                  end: const Offset(0, 0),
                                ).animate(
                                  CurvedAnimation(
                                    curve: Curves.easeInOutBack,
                                    parent: animation,
                                  ),
                                ),
                                child: ListOfIconData(
                                  listOfIconData: _listOfIcons[index],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(),
                !circleButtonState
                    ? const Padding(
                        padding: EdgeInsets.only(top: Dimensions.buttonPadding),
                        child: Icon(
                          Icons.add,
                          color: ColoursAssets.white,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadItems() {
    var future = Future(() {});
    for (var index = 0; index < _listOfIcons.length; index++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 40), () {
          _listOfWidgetsKey.currentState?.insertItem(index);
        });
      });
    }
  }
}

class ListOfIconData extends StatelessWidget {
  final IconData listOfIconData;

  const ListOfIconData({
    Key? key,
    required this.listOfIconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.buttonContentPadding),
      child: CircleAvatar(
        backgroundColor: ColoursAssets.white.withOpacity(Dimensions.buttonContentOpacityValue),
        child: Icon(
          listOfIconData,
          color: ColoursAssets.white,
        ),
        radius: Dimensions.circularButtonContentRadius,
      ),
    );
  }
}

class _IconButton extends StatefulWidget {
  final Function()? onPress;
  final IconData? icon;
  final double? padding;

  const _IconButton({
    Key? key,
    this.onPress,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  State<_IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<_IconButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.padding ?? Dimensions.iconsLeftPadding),
      child: IconButton(
        onPressed: widget.onPress,
        icon: Icon(widget.icon),
      ),
    );
  }
}
