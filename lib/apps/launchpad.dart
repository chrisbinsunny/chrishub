import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/components/finderWindow.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../componentsOnOff.dart';
import '../openApps.dart';
import '../providers.dart';
import '../sizes.dart';
import 'calendar.dart';
import 'feedback/feedback.dart';
import 'messages/messages.dart';
import 'safari/safariWindow.dart';
import 'spotify.dart';
import 'terminal/terminal.dart';
import 'vscode.dart';

class LaunchPad extends StatefulWidget {
  const LaunchPad({Key key}) : super(key: key);

  @override
  _LaunchPadState createState() => _LaunchPadState();
}

class _LaunchPadState extends State<LaunchPad> {
  DateTime now;
  bool _animate = false;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool launchPadOpen= Provider.of<OnOff>(context).getLaunchPad;
    bool safariOpen = Provider.of<Apps>(context).isOpen(ObjectKey("safari"));
    bool vsOpen = Provider.of<Apps>(context).isOpen(ObjectKey("vscode"));
    bool messageOpen = Provider.of<Apps>(context).isOpen(ObjectKey("messages"));
    bool spotifyOpen = Provider.of<Apps>(context).isOpen(ObjectKey("spotify"));
    String fs = Provider.of<OnOff>(context).getFS;
    bool fsAni = Provider.of<OnOff>(context).getFSAni;
    bool fbOpen = Provider.of<Apps>(context).isOpen(ObjectKey("feedback"));
    bool calendarOpen = Provider.of<Apps>(context).isOpen(ObjectKey("calendar"));
    bool terminalOpen = Provider.of<Apps>(context).isOpen(ObjectKey("terminal"));
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: launchPadOpen?1:0,
      curve: Curves.easeInOut,
      child: Stack(
        children: [
          Container(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Image.asset(
                themeNotifier.isDark()
                    ? "assets/wallpapers/bigsur_dark.jpg"
                    : "assets/wallpapers/bigsur_light.jpg",
                fit: BoxFit.cover,
              )),
          ClipRect(
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 23.0, sigmaY: 23.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, mulBy: 0.12),
                  vertical: screenHeight(context, mulBy: 0.1)
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight(context, mulBy: 0.1),
                    ),
                    Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6
                        ),
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
                            child: LaunchPadItem(
                              iName: "finder",
                              on: true,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<OnOff>(context, listen: false).toggleLaunchPad();
                            },
                            child: LaunchPadItem(
                              iName: "launchpad",
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
                            child: LaunchPadItem(
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
                            child: LaunchPadItem(
                              iName: "messages",
                              on: messageOpen,
                            ),
                          ),
                          LaunchPadItem(
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
                            child: LaunchPadItem(
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
                            child: LaunchPadItem(
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
                            child: LaunchPadItem(
                              iName: "vscode",
                              on: vsOpen,
                            ),
                          ),
                          LaunchPadItem(
                            iName: "photos",
                            on: false,
                          ),
                          LaunchPadItem(
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
                                        )),
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
                          LaunchPadItem(
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
                            child: LaunchPadItem(
                              iName: "feedback",
                              on: fbOpen,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<OnOff>(context, listen: false).onNotifications();
                            },
                            child: LaunchPadItem(
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
            ),
          ),
        ],
      ),
    );
  }
}


class LaunchPadItem extends StatefulWidget {
  final String iName;
  final bool on;
  LaunchPadItem({
    Key key,
    @required this.iName,
    this.on = false,
  }) : super(key: key);

  @override
  _LaunchPadItemState createState() => _LaunchPadItemState();
}

class _LaunchPadItemState extends State<LaunchPadItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            "assets/apps/${widget.iName.toLowerCase()}.png",
            fit: BoxFit.scaleDown,
          ),
          height: 60,
        ),
        MBPText(
          text: widget.iName,
            color: Colors.white
        )
      ],
    );
  }
}