import 'dart:developer';

import 'package:example/constant/dimens.dart' as example;
import 'package:example/constant/strings.dart' as example;
import 'package:example/constant/styles.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'constant/colors.dart' as example;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: example.Strings.appName,
      theme: ThemeData(fontFamily: Fonts.poppins),
      home: const BottomNavigatorExample(title: example.Strings.appName),
    );
  }
}

class BottomNavigatorExample extends StatefulWidget {
  const BottomNavigatorExample({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<BottomNavigatorExample> createState() => _BottomNavigatorExampleState();
}

class _BottomNavigatorExampleState extends State<BottomNavigatorExample> {
  bool circleButtonToggle = false;
  List<Color> listOfColor = [
    const Color(0xFFF2B5BA),
    Colors.orange,
    Colors.amber,
    Colors.deepOrangeAccent
  ];
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 3,
              backgroundColor: example.AppColors.cherryRed,
              title: Text(widget.title),
            ),
            backgroundColor: listOfColor[index],
            floatingActionButton: const SizedBox(
              height: example.Dimens.heightNormal,
              width: example.Dimens.widthNormal,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              barColor: Colors.white,
              controller: FloatingBottomBarController(initialIndex: 1),
              bottomBar: [
                BottomBarItem(
                  icon: const Icon(Icons.home, size: example.Dimens.iconNormal),
                  iconSelected: const Icon(Icons.home,
                      color: example.AppColors.cherryRed,
                      size: example.Dimens.iconNormal),
                  title: example.Strings.home,
                  dotColor: example.AppColors.cherryRed,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                    log('Home $value');
                  },
                ),
                BottomBarItem(
                  icon:
                      const Icon(Icons.photo, size: example.Dimens.iconNormal),
                  iconSelected: const Icon(Icons.photo,
                      color: example.AppColors.cherryRed,
                      size: example.Dimens.iconNormal),
                  title: example.Strings.search,
                  dotColor: example.AppColors.cherryRed,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                    log('Search $value');
                  },
                ),
                BottomBarItem(
                  icon:
                      const Icon(Icons.person, size: example.Dimens.iconNormal),
                  iconSelected: const Icon(Icons.person,
                      color: example.AppColors.cherryRed,
                      size: example.Dimens.iconNormal),
                  title: example.Strings.person,
                  dotColor: example.AppColors.cherryRed,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                    log('Profile $value');
                  },
                ),
                BottomBarItem(
                  icon: const Icon(Icons.settings,
                      size: example.Dimens.iconNormal),
                  iconSelected: const Icon(Icons.settings,
                      color: example.AppColors.cherryRed,
                      size: example.Dimens.iconNormal),
                  title: example.Strings.settings,
                  dotColor: example.AppColors.cherryRed,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                    log('Settings $value');
                  },
                ),
              ],
              bottomBarCenterModel: BottomBarCenterModel(
                centerBackgroundColor: example.AppColors.cherryRed,
                centerIcon: const FloatingCenterButton(
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                ),
                centerIconChild: [
                  FloatingCenterButtonChild(
                    child: const Icon(
                      Icons.home,
                      color: AppColors.white,
                    ),
                    onTap: () => log('Item1'),
                  ),
                  FloatingCenterButtonChild(
                    child: const Icon(
                      Icons.access_alarm,
                      color: AppColors.white,
                    ),
                    onTap: () => log('Item2'),
                  ),
                  FloatingCenterButtonChild(
                    child: const Icon(
                      Icons.ac_unit_outlined,
                      color: AppColors.white,
                    ),
                    onTap: () => log('Item3'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
