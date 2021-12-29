import 'dart:developer';

import 'package:bottom_navigator_animation/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'constant/colors_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigator Animation',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const BottomNavigatorExample(title: 'Bottom Navigator Animation'),
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
              backgroundColor: Colours.cherryRed,
              title: Text(widget.title),
            ),
            backgroundColor: Colours.lightPink,
            floatingActionButton: const SizedBox(
              height: 50.0,
              width: 50.0,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const BottomNavBarBody(),
          ),
          // _animatedContainer()
        ],
      ),
    );
  }
}
