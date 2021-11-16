import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../components/windowWidgets.dart';
import '../system/openApps.dart';
import '../sizes.dart';
import '../widgets.dart';


class Finder extends StatefulWidget {
  final Offset initPos;
  const Finder({this.initPos, Key key}) : super(key: key);

  @override
  _FinderState createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  Offset position = Offset(0.0, 0.0);
  String selected = "Applications";
  bool finderFS;
  bool finderPan;

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var finderOpen = Provider.of<OnOff>(context).getFinder;
    finderFS = Provider.of<OnOff>(context).getFinderFS;
    finderPan = Provider.of<OnOff>(context).getFinderPan;
      return AnimatedPositioned(
            duration: Duration(milliseconds: finderPan ? 0 : 200),
            top: finderFS ? screenHeight(context, mulBy: 0.034) : position.dy,
            left: finderFS ? 0 : position.dx,
            child: finderWindow(context),
          );
  }

  AnimatedContainer finderWindow(BuildContext context) {
    String thm = Provider.of<ThemeNotifier>(context).findThm;
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: finderFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: finderFS
          ? screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.65),
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
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.013),
                        vertical: screenHeight(context, mulBy: 0.025)),
                    height: screenHeight(context),
                    width: screenWidth(context, mulBy: 0.14),
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    .offFinderFS();
                                Provider.of<Apps>(context, listen: false)
                                    .closeApp("finder");
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleFinder();
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleFinder();
                                Provider.of<OnOff>(context, listen: false)
                                    .offFinderFS();
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
                            InkWell(
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleFinderFS();
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.035),
                        ),
                        Text(
                          "Favourites",
                          style: TextStyle(
                            fontWeight: Theme.of(context)
                                .textTheme
                                .headline1
                                .fontWeight,
                            fontFamily: "SF",
                            color: Theme.of(context).cardColor.withOpacity(.38),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.015),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                selected = "Applications";
                              });
                            },
                            child: LeftPaneItems(
                              iName: "Applications",
                              isSelected:
                                  (selected == "Applications") ? true : false,
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Desktop";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Desktop",
                            isSelected: (selected == "Desktop") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Documents";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Documents",
                            isSelected:
                                (selected == "Documents") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Downloads";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Downloads",
                            isSelected:
                                (selected == "Downloads") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Movies";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Movies",
                            isSelected: (selected == "Movies") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Music";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Music",
                            isSelected: (selected == "Music") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Pictures";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Pictures",
                            isSelected: (selected == "Pictures") ? true : false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, mulBy: 0.013),
                      vertical: screenHeight(context, mulBy: 0.03)),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icons/back$thm.png",
                                  height: 18),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.01),
                              ),
                              Image.asset("assets/icons/forw$thm.png",
                                  height: 18.5),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.007),
                              ),
                              Container(
                                width: screenWidth(context, mulBy: 0.07),
                                child: MBPText(
                                  text: selected,
                                  size: 15,
                                  weight: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .fontWeight,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(1),
                                  // style: TextStyle(
                                  //   fontWeight: FontWeight.w700,
                                  //   color: Colors.black.withOpacity(0.7),
                                  //   fontSize: 15,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                          Image.asset("assets/icons/sort$thm.png", height: 20),
                          Row(
                            children: [
                              Image.asset("assets/icons/icon$thm.png",
                                  height: 18),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.015),
                              ),
                              Image.asset("assets/icons/share$thm.png",
                                  height: 19),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.015),
                              ),
                              Image.asset("assets/icons/tag$thm.png",
                                  height: 15),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("assets/icons/more$thm.png",
                                  height: 15),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.007),
                              ),
                              Image.asset("assets/icons/search$thm.png",
                                  height: 15),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!finderFS) {
                setState(() {
                  position = Offset(position.dx + tapInfo.delta.dx,
                      position.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onFinderPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offFinderPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleFinderFS();
            },
            child: Container(
                alignment: Alignment.centerRight,
                width: finderFS
                    ? screenWidth(context, mulBy: 0.95)
                    : screenWidth(context, mulBy: 0.5),
                height: screenHeight(context, mulBy: 0.04),
                color: Colors.transparent),
          ),
          Visibility(
            visible: topApp != "Finder",
            child: InkWell(
              onTap: (){
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("finder"));
              },
              child: Container(
                width: screenWidth(context,),
                height: screenHeight(context,),
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
