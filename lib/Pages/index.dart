import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contact.dart';
import 'parallax.dart';
import 'fppView.dart';
import 'showcase.dart';
import '../Theme/theme.dart';
import '../Widgets/Text.dart';
import '../Widgets/buttons.dart';
import '../sizes.dart';
import 'pageItems.dart';
import 'dart:math' as math;
import 'dart:ui';

class IndexPage extends StatefulWidget {
  final ThemeNotifier theme;
  IndexPage(this.theme);
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenWidth(context), 1000),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              // will be 10 by default if not provided
              sigmaX: 35,
              sigmaY: 35,
            ),
            child: Container(
              //color: Colors.white.withOpacity(0.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide( //                   <--- left side
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                gradient: RadialGradient(
                    colors: [Colors.white.withOpacity(0.08), Colors.transparent],
                    //colors: [Colors.red, Colors.blue],
                    radius: 17,
                    center: Alignment.topLeft),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    topBarText("CHRISBIN", size: 36),
                    //TODO: Shimmer here
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                controller.animateTo(0 * screenHeight(context),
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 500));
                              },
                              child: topBarText("HOME")),
                          SizedBox(width: screenWidth(context) / 30),
                          InkWell(
                              onTap: () {
                                controller.animateTo(screenHeight(context),
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 500));
                              },
                              child: topBarText("FPP VIEW")),
                          SizedBox(width: screenWidth(context) / 30),
                          InkWell(
                              onTap: () {
                                controller.animateTo(2 * screenHeight(context),
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 500));
                              },
                              child: topBarText("LOADOUTS")),
                          SizedBox(width: screenWidth(context) / 30),
                          InkWell(
                              onTap: () {
                                controller.animateTo(3 * screenHeight(context),
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 500));
                              },
                              child: topBarText("TPP VIEW")),
                          SizedBox(width: screenWidth(context) / 30),
                          topBarText("DARK MODE"),
                          SizedBox(
                            width: screenWidth(context) / 50,
                          ),
                          DarkModeToggle(widget.theme),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            //ParallaxViewTransparent(),
            FppView(context),
            //ShowCase(),
            //Contact(),
          ],
        ),
      )
      // ListView.builder(
      //     controller: controller,
      //     padding: EdgeInsets.zero,
      //     itemCount: pageItems.length,
      //     itemBuilder: (context, index) {
      //       return pageItems[index];
      //     }),
    );
  }
}
