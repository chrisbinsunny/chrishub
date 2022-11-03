import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

//TODO: BUG Found>> After opening youtube all searches redirects to youtube.

class SystemPreferences extends StatefulWidget {
  final Offset? initPos;
  const SystemPreferences({this.initPos, Key? key}) : super(key: key);

  @override
  _SystemPreferencesState createState() => _SystemPreferencesState();
}

class _SystemPreferencesState extends State<SystemPreferences> {
  Offset? position = Offset(0.0, 0.0);
  late bool sysPrefPan;
  late TextEditingController controller;

  @override
  void initState() {
    position = widget.initPos;
    controller=TextEditingController()..addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sysPrefOpen = Provider.of<OnOff>(context).getSysPref;
    sysPrefPan = Provider.of<OnOff>(context).getSysPrefPan;
    return sysPrefOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: sysPrefPan ? 0 : 200),
            top: position!.dy,
            left: position!.dx,
            child: sysPrefWindow(context),
          )
        : Container();
  }

  AnimatedContainer sysPrefWindow(BuildContext context) {
    String thm = Provider.of<ThemeNotifier>(context).findThm;
    String topApp = Provider.of<Apps>(context).getTop;
    log(screenHeight(context, mulBy: 0.05).toString());
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: screenWidth(context, mulBy: 0.35),
      height: screenHeight(context, mulBy: 0.55),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///Top
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: screenHeight(context, mulBy: 0.05),
                    constraints: constraints(height: 0.05),
                    decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15))),
                  ),
                  GestureDetector(
                    onPanUpdate: (tapInfo) {
                      setState(() {
                        position = Offset(position!.dx + tapInfo.delta.dx,
                            position!.dy + tapInfo.delta.dy);
                      });
                    },
                    onPanStart: (details) {
                      Provider.of<OnOff>(context, listen: false).onSysPrefPan();
                    },
                    onPanEnd: (details) {
                      Provider.of<OnOff>(context, listen: false)
                          .offSysPrefPan();
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      width: screenWidth(context, mulBy: 0.7),
                      height: screenHeight(context, mulBy: 0.05),
                      constraints: constraints(height: 0.05),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 0.8))),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Colors.black,
                        width: 0.8
                      ))
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.013),
                        vertical: screenHeight(context, mulBy: 0.01)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .offSafariFS();
                                Provider.of<Apps>(context, listen: false)
                                    .closeApp("systemPreferences");
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleSysPref();
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleSysPref();
                              },
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            Container(
                              height: 11.5,
                              width: 11.5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.015),
                        ),
                        Icon(
                          CupertinoIcons.back,
                          color: Colors.grey.withOpacity(0.4),
                          size: 20,
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.01),
                        ),
                        Icon(
                          CupertinoIcons.forward,
                          color: Colors.grey.withOpacity(0.4),
                          size: 20,
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.013),
                        ),
                        Icon(
                          CupertinoIcons.square_grid_4x3_fill,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.01),
                        ),
                        MBPText(
                          text: "System Preferences",
                          size: 15,
                          weight:
                              Theme.of(context).textTheme.headline3!.fontWeight,
                          color: Theme.of(context).cardColor.withOpacity(1),
                          softWrap: true,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          width: screenWidth(context, mulBy: 0.09),
                          height: screenHeight(context, mulBy: 0.028),
                          constraints: constraints(height: 0.028),
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.start,
                            controller: controller,
                            cursorColor:
                                Theme.of(context).cardColor.withOpacity(0.55),
                            cursorHeight: 13,
                            cursorWidth: 1,
                            style: TextStyle(
                              height: 0,
                              color: Theme.of(context).cardColor.withOpacity(0.9),
                              fontFamily: "HN",
                              fontWeight: FontWeight.w300,
                              fontSize: 11.5,
                              letterSpacing: 0.5
                            ),
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: "Search",
                                isCollapsed: false,
                                suffixIcon: Visibility(
                                  visible: controller.text!="",
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      size: 15,
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.55),
                                    ),
                                    onPressed: () {
                                      controller.clear();

                                    },
                                  ),
                                ),
                                contentPadding:EdgeInsets.zero,
                                prefixIcon: Icon(
                                  CupertinoIcons.search,
                                  size: 15,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.55),
                                ),
                                hintStyle: TextStyle(
                                  height: 0,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.4),
                                  fontFamily: "SF",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.5,
                                  letterSpacing: 0
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.2),
                                      width: 0.5
                                    )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent.withOpacity(0.7),
                                      width: 2
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              ///Content part
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        // borderRadius: BorderRadius.only(
                        //     bottomRight: Radius.circular(15),
                        //     bottomLeft: Radius.circular(15)),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context, mulBy: 0.02),
                        horizontal: screenWidth(context, mulBy: 0.011)
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset("assets/wallpapers/iPadOS_light.jpg", fit: BoxFit.cover,),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            height: screenHeight(context, mulBy: 0.065),
                            width: screenHeight(context, mulBy: 0.065),
                            constraints: constraints(
                              height: 0.065
                            ),
                          ),
                          SizedBox(
                            width: screenWidth(context, mulBy: 0.007),
                          ),
                          RichText(
                              text: TextSpan(
                                text: "Chrisbin Sunny\n",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(0.9),
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "SF",
                              letterSpacing: 0.3
                            ),
                            children: [
                              TextSpan(
                                text: "Apple ID, iCloud, Media & App Store\n",
                                style: TextStyle(
                                  fontSize: 11
                                )
                              )
                            ]
                          )),
                          Spacer(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                child: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Image.asset(
                                      "assets/sysPref/appleID.png"
                                  ),
                                ),
                              ),
                              Text(
                                "Apple ID\n",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SF",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: screenWidth(context, mulBy: 0.022),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              FittedBox(
                                child: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Image.asset(
                                    "assets/sysPref/familySharing.png"
                                  ),
                                ),
                              ),
                              Text(
                                "Family\nSharing",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SF",
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: topApp != "System Preferences",
            child: InkWell(
              onTap: () {
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("systemPreferences"));
              },
              child: Container(
                width: screenWidth(
                  context,
                ),
                height: screenHeight(
                  context,
                ),
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
