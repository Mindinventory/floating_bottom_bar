import 'dart:developer';

import 'package:bottom_navigator_animation/animated_bottom_navigation_bar.dart';
import 'package:example/constant/dimens.dart' as example;
import 'package:example/constant/strings.dart' as example;
import 'package:example/constant/styles.dart';
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
  const BottomNavigatorExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BottomNavigatorExample> createState() => _BottomNavigatorExampleState();
}

class _BottomNavigatorExampleState extends State<BottomNavigatorExample> {
  bool circleButtonToggle = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: example.AppColors.cherryRed,
              title: Text(widget.title),
            ),
            backgroundColor: example.AppColors.lightPink,
            floatingActionButton: const SizedBox(
              height: example.Dimens.heightNormal,
              width: example.Dimens.widthNormal,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: const Center(child: Text('Text')),
            bottomNavigationBar: AnimatedBottomNavigationBar(
              menuItems: [
                BottomBarItemsModel(
                  icon: const Icon(Icons.home, size: example.Dimens.iconNormal),
                  iconSelected: const Icon(Icons.home, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                  title: example.Strings.home,
                  dotColor: example.AppColors.cherryRed,
                  onTap: (){
                    log('bla bla bla');
                  }
                ),
                const BottomBarItemsModel(
                  icon: Icon(Icons.search, size: example.Dimens.iconNormal),
                  iconSelected: Icon(Icons.search, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                  title: example.Strings.search,
                  dotColor: example.AppColors.cherryRed,
                ),
                const BottomBarItemsModel(
                  icon: Icon(Icons.person, size: example.Dimens.iconNormal),
                  iconSelected: Icon(Icons.person, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                  title: example.Strings.person,
                  dotColor: example.AppColors.cherryRed,
                ),
                const BottomBarItemsModel(
                  icon: Icon(Icons.settings, size: example.Dimens.iconNormal),
                  iconSelected: Icon(Icons.settings, color: AppColors.cherryRed, size: example.Dimens.iconNormal),
                  title: example.Strings.settings,
                  dotColor: example.AppColors.cherryRed,
                ),
              ],
              menuCenterModel: BottomBarCenterModel(
                centerBackgroundColor: example.AppColors.black,
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
                    onTap: (){
                      log('bla bla bla');
                    },
                  ),
                  const FloatingCenterButtonChild(
                    child: Icon(
                      Icons.home,
                      color: AppColors.white,
                    ),
                  ),
                  const FloatingCenterButtonChild(
                    child: const Icon(
                      Icons.home,
                      color: AppColors.white,
                    ),
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
