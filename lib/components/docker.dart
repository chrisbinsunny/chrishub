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

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool safariOpen = Provider.of<Apps>(context).isOpen(ObjectKey("safari"));
    bool vsOpen = Provider.of<Apps>(context).isOpen(ObjectKey("vscode"));
    bool messageOpen = Provider.of<Apps>(context).isOpen(ObjectKey("messages"));
    bool spotifyOpen = Provider.of<Apps>(context).isOpen(ObjectKey("spotify"));
    String fs = Provider.of<OnOff>(context).getFS;
    bool fsAni = Provider.of<OnOff>(context).getFSAni;
    bool fbOpen = Provider.of<Apps>(context).isOpen(ObjectKey("feedback"));
    bool calendarOpen = Provider.of<Apps>(context).isOpen(ObjectKey("calendar"));
    bool terminalOpen = Provider.of<Apps>(context).isOpen(ObjectKey("terminal"));

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
                          iName: "finder",
                          on: true,
                        ),
                      ),
                      DockerItem(
                        iName: "launchpad",
                        on: false,
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
                          iName: "safari",
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
                          iName: "messages",
                          on: messageOpen,
                        ),
                      ),
                      DockerItem(
                        iName: "maps",
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
                          iName: "spotify",
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
                          iName: "terminal",
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
                          iName: "vscode",
                          on: vsOpen,
                        ),
                      ),
                      DockerItem(
                        iName: "photos",
                        on: false,
                      ),
                      DockerItem(
                        iName: "contacts",
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
                        iName: "notes",
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
                          iName: "feedback",
                          on: fbOpen,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<Folders>(context, listen: false).deSelectAll();
                          setState(() {
                             // showMacosAlertDialog(
                             //    context: context,
                             //    builder: (_) => MacosAlertDialog(
                             //     appIcon: FlutterLogo(
                             //       size: 56,
                             //     ),
                             //     title: Text(
                             //       'Alert Dialog with Primary Action',
                             //     ),
                             //     message: Text(
                             //       'This is an alert dialog with a primary action and no secondary action',
                             //     ),
                             //     primaryButton: MaterialButton(
                             //       //buttonSize: ButtonSize.large,
                             //       child: Text('Primary'),
                             //       onPressed: Navigator.of(context).pop,
                             //     ),
                             //   ),
                             // );
                          });
                        },
                        child: DockerItem(
                          iName: "system-preferences",
                          on: false,
                        ),
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
