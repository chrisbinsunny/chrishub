import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../componentsOnOff.dart';
import '../sizes.dart';

class ControlCentre extends StatefulWidget {
  const ControlCentre({Key key}) : super(key: key);

  @override
  _ControlCentreState createState() => _ControlCentreState();
}

class _ControlCentreState extends State<ControlCentre> {
  BoxShadow ccShadow = BoxShadow(
    color: Colors.black.withOpacity(.2),
    spreadRadius: 1,
    blurRadius: 2,
    offset: Offset(0, 1), // changes position of shadow
  );
  @override
  Widget build(BuildContext context) {
    BoxDecoration ccDecoration = BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(.2),
        border: Border.all(color: Theme.of(context).cardColor),
        borderRadius:BorderRadius.all(Radius.circular(10)),

    // backgroundBlendMode: BlendMode.softLight,
    );
    debugPrint("${screenHeight(context, mulBy: 1)}");
    debugPrint("${screenWidth(context, mulBy: 1)}");
    var ccOpen = Provider.of<OnOff>(context).getCc;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ccOpen
        ? Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.007),
                          vertical: screenHeight(context, mulBy: 0.014)),
                      height: screenHeight(context, mulBy: 0.45),
                      width: screenWidth(context, mulBy: 0.2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [ccShadow],
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15.0, sigmaY: 15.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              mulBy: 0.013),
                                          vertical: screenHeight(context,
                                              mulBy: 0.025)),
                                      height:
                                          screenHeight(context, mulBy: 0.17),
                                      width: screenWidth(context, mulBy: 0.09),
                                      decoration: ccDecoration,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight(context, mulBy: 0.17),
                                width: screenWidth(context, mulBy: 0.09),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [ccShadow],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15.0, sigmaY: 15.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth(context,
                                                    mulBy: 0.013),
                                                vertical: screenHeight(context,
                                                    mulBy: 0.025)),
                                            height: screenHeight(context,
                                                mulBy: 0.08),
                                            width: screenWidth(context,
                                                mulBy: 0.09),
                                            decoration: ccDecoration,
                                            child: Row(
                                              children: [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [ccShadow],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15.0, sigmaY: 15.0),
                                          child: Container(
                                            // padding: EdgeInsets.symmetric(
                                            //     horizontal: screenWidth(context,
                                            //         mulBy: 0.013),
                                            //     vertical: screenHeight(context,
                                            //         mulBy: 0.015)),
                                            height: screenHeight(context,
                                                mulBy: 0.08),
                                            width: screenWidth(context,
                                                mulBy: 0.09),
                                            decoration: ccDecoration,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    themeNotifier.isDark()
                                                        ? themeNotifier
                                                            .setTheme(
                                                                ThemeNotifier
                                                                    .lightTheme)
                                                        : themeNotifier
                                                            .setTheme(
                                                                ThemeNotifier
                                                                    .darkTheme);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 15.0,
                                                          sigmaY: 15.0),
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            mulBy: 0.0456),
                                                        width: screenWidth(
                                                            context,
                                                            mulBy: 0.0219),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Theme.of(context)
                                                                  .buttonColor,
                                                        ),
                                                        child: Center(
                                                          child: Image.asset(
                                                            "assets/icons/darkBlack.png",
                                                            height:
                                                                screenHeight(
                                                                    context,
                                                                    mulBy:
                                                                        0.032),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                    child: MBPText(
                                                        text:
                                                            "Dark Mode\n${themeNotifier.isDark() ? "On" : "Off"}"))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [ccShadow],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [ccShadow],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [ccShadow],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
