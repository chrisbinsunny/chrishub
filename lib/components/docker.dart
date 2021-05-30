import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../componentsOnOff.dart';
import '../widgets.dart';
import 'hoverDock.dart';

import '../sizes.dart';

class Docker extends StatefulWidget {
  const Docker({
    Key key,
  }) : super(key: key);

  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {
  DateTime now;
  bool _animate=false;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                CustomBoxShadow(
                  color: Theme.of(context).accentColor,
                    //color: Colors.black.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                    blurStyle: BlurStyle.normal
              ),
              ]
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 2),
                      width: screenWidth(context, mulBy: 0.7),
                      height: screenHeight(context, mulBy: 0.09),
                      decoration: BoxDecoration(
                          color: Theme.of(context).focusColor,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 2),
                  width: screenWidth(context, mulBy: 0.7),
                  height: screenHeight(context, mulBy: 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _animate = !_animate;
                          });
                          Provider.of<OnOff>(context, listen: false)
                              .openFinder();
                        },
                        child: DockerItem(
                          iName: "finder",
                          on: true,
                        ),
                      ),
                      DockerItem(
                        iName: "launchpad",
                        on: false,
                      ),
                      DockerItem(
                        iName: "safari",
                        on: false,
                      ),
                      DockerItem(
                        iName: "messages",
                        on: false,
                      ),
                      DockerItem(
                        iName: "maps",
                        on: false,
                      ),
                      DockerItem(
                        iName: "mail",
                        on: false,
                      ),
                      DockerItem(
                        iName: "terminal",
                        on: false,
                      ),
                      DockerItem(
                        iName: "xcode",
                        on: false,
                      ),
                      DockerItem(
                        iName: "photos",
                        on: false,
                      ),
                      DockerItem(
                        iName: "contacts",
                        on: false,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Image.asset(
                                    "assets/apps/calendar.png",
                                  ),
                                  Positioned(
                                    top: screenHeight(context, mulBy: 0.01),
                                    child: Container(
                                      height: screenHeight(context, mulBy: 0.02),
                                      width: screenWidth(context, mulBy: 0.03),
                                      color: Colors.transparent,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          "${DateFormat('LLL').format(now).toUpperCase()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'SF',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: screenHeight(context, mulBy: 0.026),
                                    child: Container(
                                      height: screenHeight(context, mulBy: 0.047),
                                      width: screenWidth(context, mulBy: 0.03),
                                      color: Colors.transparent,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(
                                          "${DateFormat('d').format(now).toUpperCase()}",
                                          style: TextStyle(
                                              color:
                                                  Colors.black87.withOpacity(0.8),
                                              fontFamily: 'SF',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 28),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )).moveUpOnHover,
                            ),
                            Container(
                              height: 4,
                              width: 4,
                              decoration: BoxDecoration(
                                color: true ? Colors.black : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DockerItem(
                        iName: "notes",
                        on: false,
                      ),
                      DockerItem(
                        iName: "appstore",
                        on: false,
                      ),
                      DockerItem(
                        iName: "system-preferences",
                        on: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight(context, mulBy: 0.01),
          )
        ],
      ),
    );
  }
}

class DockerItem extends StatefulWidget {
  final String iName;
  final bool on;
  DockerItem({
    Key key,
    @required this.iName,
    this.on = false,
  }) : super(key: key);

  @override
  _DockerItemState createState() => _DockerItemState();
}

class _DockerItemState extends State<DockerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
                  child: Image.asset(
            "assets/apps/${widget.iName}.png",
          )).moveUpOnHover),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: widget.on ? Colors.black : Colors.transparent,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    ).showCursorOnHover;
  }
}
