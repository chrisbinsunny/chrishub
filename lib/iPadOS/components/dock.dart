import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/messages/messages.dart';
import 'package:provider/provider.dart';
import '../../system/componentsOnOff.dart';
import '../../system/folders.dart';
import '../../system/openApps.dart';
import '../../providers.dart';
import '../../widgets.dart';
import '../../components/finderWindow.dart';
import '../../sizes.dart';
import '../../apps/feedback/feedback.dart';
import '../../apps/spotify.dart';
import '../../apps/terminal/terminal.dart';
import '../../apps/vscode.dart';
import '../../apps/safari/safariWindow.dart';

//TODO: Icons are not clickable outside of Dock. Known issue of framework. Need to find a Workaround.

class Docker extends StatefulWidget {
  const Docker({
    Key key,
  }) : super(key: key);

  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {
  DateTime now;
  bool safariOpen, vsOpen, messageOpen,spotifyOpen, fbOpen, calendarOpen, terminalOpen;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
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
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    CustomBoxShadow(
                        color: Theme.of(context).accentColor,
                        //color: Colors.black.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 15,
                        offset: Offset(0, 8),
                        blurStyle: BlurStyle.normal),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 2),
                      width: screenWidth(context, mulBy: 0.7),
                      height: screenHeight(context, mulBy: 0.09),
                      decoration: BoxDecoration(
                          color: Theme.of(context).focusColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DockerItem(
                              iName: "Safari",
                              on: safariOpen,
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
                            ),
                            DockerItem(
                              iName: "Messages",
                              on: messageOpen,
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
                              ),
                            ),
                            DockerItem(
                              iName: "Notes",
                              on: false,

                            ),
                            DockerItem(
                              iName: "Feedback",
                              on: fbOpen,
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
                            ),
                            DockerItem(
                              iName: "System Preferences",
                              on: false,
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false).onNotifications();
                              },
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ),

            ],
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
  VoidCallback onTap=(){};
  DockerItem({
    Key key,
    @required this.iName,
    this.on = false,
    this.onTap
  }) : super(key: key);

  @override
  _DockerItemState createState() => _DockerItemState();
}

class _DockerItemState extends State<DockerItem> {

  @override
  Widget build(BuildContext context) {
    //print("${widget.iName}: ${widget.dx}");
    return InkWell(
      onTap: widget.onTap,
      mouseCursor: MouseCursor.defer,
      child: Image.asset(
        "assets/apps/${widget.iName.toLowerCase()}.png",
      ),
    );
  }
}
