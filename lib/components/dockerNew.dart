import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/messages/messages.dart';
import 'package:provider/provider.dart';
import '../componentsOnOff.dart';
import '../folders.dart';
import '../openApps.dart';
import '../providers.dart';
import '../widgets.dart';
import 'alertDialog.dart';
import 'finderWindow.dart';
import 'hoverDock.dart';

import '../sizes.dart';
import 'package:flutter/scheduler.dart';

import '../apps/calendar.dart';
import '../apps/feedback/feedback.dart';
import '../apps/spotify.dart';
import '../apps/terminal/terminal.dart';
import '../apps/vscode.dart';
import '../components/finderWindow.dart';
import '../apps/safari/safariWindow.dart';

class Docker extends StatefulWidget {
  const Docker({
    Key key,
  }) : super(key: key);

  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {
  DateTime now;
  bool _animate = false;
  var _offset = 0.0;
  var _currentIndex = -1;
  List<Widget> dockItems= [];
  bool safariOpen, vsOpen, messageOpen,spotifyOpen, fbOpen, calendarOpen, terminalOpen;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dockItems=[
        InkWell(
          onTap: () {
            setState(() {
              _animate = !_animate;
            });
            tapFunctions(context);
            Provider.of<OnOff>(context, listen: false)
                .maxFinder();
            Provider.of<Apps>(context, listen: false).openApp(
                Finder(
                    key: ObjectKey("finder"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.2),
                        screenHeight(context, mulBy: 0.18))),
                Provider.of<OnOff>(context, listen: false)
                    .maxFinder()
            );
          },
          child: DockerItem(
            iName: "Finder",
            on: true,
          ),
        ),
        InkWell(
          onTap: () {
            Provider.of<Folders>(context, listen: false).deSelectAll();
            Provider.of<OnOff>(context, listen: false).offNotifications();
            Provider.of<OnOff>(context, listen: false).offFRCM();
            Provider.of<OnOff>(context, listen: false).offRCM();
            Provider.of<OnOff>(context, listen: false).toggleLaunchPad();
          },
          child: DockerItem(
            iName: "Launchpad",
            on: false,
          ),
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);
            Provider.of<OnOff>(context, listen: false)
                .maxSafari();
            Provider.of<Apps>(context, listen: false).openApp(
                Safari(
                    key: ObjectKey("safari"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.14),
                        screenHeight(context, mulBy: 0.1))),
                Provider.of<OnOff>(context, listen: false)
                    .maxSafari()
            );
          },
          child: DockerItem(
            iName: "Safari",
            on: safariOpen,
          ),
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);

            Provider.of<OnOff>(context, listen: false)
                .maxMessages();
            Provider.of<Apps>(context, listen: false).openApp(
                Messages(
                    key: ObjectKey("messages"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.14),
                        screenHeight(context, mulBy: 0.1))),
                Provider.of<OnOff>(context, listen: false)
                    .maxMessages()
            );
          },
          child: DockerItem(
            iName: "Messages",
            on: messageOpen,
          ),
        ),
        DockerItem(
          iName: "Maps",
          on: false,
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);

            Provider.of<OnOff>(context, listen: false)
                .maxSpotify();
            Provider.of<Apps>(context, listen: false).openApp(
                Spotify(
                    key: ObjectKey("spotify"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.14),
                        screenHeight(context, mulBy: 0.1))),
                Provider.of<OnOff>(context, listen: false)
                    .maxSpotify()
            );

          },
          child: DockerItem(
            iName: "Spotify",
            on: spotifyOpen,
          ),
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);

            Provider.of<OnOff>(context, listen: false)
                .maxTerminal();
            Provider.of<Apps>(context, listen: false).openApp(
                Terminal(
                    key: ObjectKey("terminal"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.28),
                        screenHeight(context, mulBy: 0.2))),
                Provider.of<OnOff>(context, listen: false)
                    .maxTerminal()
            );

          },
          child: DockerItem(
            iName: "Terminal",
            on: terminalOpen,
          ),
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);

            Provider.of<OnOff>(context, listen: false).maxVS();
            Provider.of<Apps>(context, listen: false).openApp(
                VSCode(
                    key: ObjectKey("vscode"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.14),
                        screenHeight(context, mulBy: 0.1))),
                Provider.of<OnOff>(context, listen: false).maxVS()
            );

          },
          child: DockerItem(
            iName: "Visual Studio Code",
            on: vsOpen,
          ),
        ),
        DockerItem(
          iName: "Photos",
          on: false,
        ),
        DockerItem(
          iName: "Contacts",
          on: false,
        ),
        InkWell(
          onTap: () {                tapFunctions(context);

          Provider.of<OnOff>(context, listen: false)
              .maxCalendar();
          Provider.of<Apps>(context, listen: false).openApp(
              Calendar(
                  key: ObjectKey("calendar"),
                  initPos: Offset(
                      screenWidth(context, mulBy: 0.14),
                      screenHeight(context, mulBy: 0.1))),
              Provider.of<OnOff>(context, listen: false)
                  .maxCalendar()
          );

          },
          child: MouseRegion(
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
                              height:
                              screenHeight(context, mulBy: 0.02),
                              width:
                              screenWidth(context, mulBy: 0.03),
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
                              height:
                              screenHeight(context, mulBy: 0.047),
                              width:
                              screenWidth(context, mulBy: 0.03),
                              color: Colors.transparent,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "${DateFormat('d').format(now).toUpperCase()}",
                                  style: TextStyle(
                                      color: Colors.black87
                                          .withOpacity(0.8),
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
                    color: calendarOpen
                        ? Theme.of(context)
                        .cardColor
                        .withOpacity(1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
        DockerItem(
          iName: "Notes",
          on: false,
        ),
        InkWell(
          onTap: () {
            tapFunctions(context);

            Provider.of<OnOff>(context, listen: false)
                .maxFeedBack();
            Provider.of<Apps>(context, listen: false).openApp(
                FeedBack(
                    key: ObjectKey("feedback"),
                    initPos: Offset(
                        screenWidth(context, mulBy: 0.14),
                        screenHeight(context, mulBy: 0.1))),
                Provider.of<OnOff>(context, listen: false)
                    .maxFeedBack()
            );
          },
          child: DockerItem(
            iName: "Feedback",
            on: fbOpen,
          ),
        ),
        InkWell(
          onTap: () {
            Provider.of<OnOff>(context, listen: false).onNotifications();
          },
          child: DockerItem(
            iName: "System Preferences",
            on: false,
          ),
        ),
      ];
    });
  }

  double _getVariation(double x, double x0, double radius) {
    if (_offset == 0) return 0;
    var z = (x - x0) * (x - x0) - radius;
    if (z > 0) return 0;
    return sqrt(-z / radius);
  }

  @override
  Widget build(BuildContext context) {
    safariOpen = Provider.of<Apps>(context).isOpen(ObjectKey("safari"));
    vsOpen = Provider.of<Apps>(context).isOpen(ObjectKey("vscode"));
    messageOpen = Provider.of<Apps>(context).isOpen(ObjectKey("messages"));
    spotifyOpen = Provider.of<Apps>(context).isOpen(ObjectKey("spotify"));
    String fs = Provider.of<OnOff>(context).getFS;
    bool fsAni = Provider.of<OnOff>(context).getFSAni;
    fbOpen = Provider.of<Apps>(context).isOpen(ObjectKey("feedback"));
    calendarOpen = Provider.of<Apps>(context).isOpen(ObjectKey("calendar"));
    terminalOpen = Provider.of<Apps>(context).isOpen(ObjectKey("terminal"));

    return AnimatedPositioned(
      duration: Duration(milliseconds: (fsAni) ? 400 : 0),
      top: (fs == "")
          ? screenHeight(context, mulBy: 0.9)
          : screenHeight(context, mulBy: 1.05),
      left: screenWidth(context, mulBy: 0.15),
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
                      blurStyle: BlurStyle.normal),
                ]),
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
                MouseRegion(
                  onHover: (event) {
                    setState(() {
                      _offset = event.localPosition.dx;
                      _currentIndex = _offset.toInt();
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _offset = 0;
                      _currentIndex = -1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    width: screenWidth(context, mulBy: 0.7),
                    height: screenHeight(context, mulBy: 0.09),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: dockItems
                    ),
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

  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..scale(1.2,1.2)..translate(-5, -25, 0, );
  bool _hovering = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  transform: _hovering ? hoverTransform: nonHoverTransform,
                  child: Image.asset(
                    "assets/apps/${widget.iName.toLowerCase()}.png",
                  )).moveUpOnHover),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: widget.on
                  ? Theme.of(context).cardColor.withOpacity(1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    ).showCursorOnHover;
  }
}
