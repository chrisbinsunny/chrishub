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
              filter: ImageFilter.blur(sigmaX: 23.0, sigmaY: 23.0),
              child: Container(
                height: screenHeight(context),
                width: screenWidth(context),
                padding: EdgeInsets.only(
                    left: screenWidth(context, mulBy: 0.12),
                  right: screenWidth(context, mulBy: 0.12),
                  bottom: screenHeight(context, mulBy: 0.17),
                  top: screenHeight(context, mulBy: 0.1)
                ),
                color: Colors.black.withOpacity(0.15),
                child: Column(
                  children: [
                    Container(

                    ),

                    Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 6/2.5,
                            mainAxisSpacing: screenHeight(context, mulBy: 0.05)
                        ),
                        shrinkWrap: true,
    physics: BouncingScrollPhysics(),
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
                              iName: "Finder",
                              on: true,
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
                            child: LaunchPadItem(
                              iName: "Messages",
                              on: messageOpen,
                            ),
                          ),
                          LaunchPadItem(
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
                            child: LaunchPadItem(
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
                            child: LaunchPadItem(
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
                            child: LaunchPadItem(
                              iName: "Visual Studio Code",
                              on: vsOpen,
                            ),
                          ),
                          LaunchPadItem(
                            iName: "Photos",
                            on: false,
                          ),
                          LaunchPadItem(
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
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: LayoutBuilder(builder: (context, cont) {
                                        return AspectRatio(
                                          aspectRatio: MediaQuery.of(context).size.aspectRatio,
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Image.asset(
                                                "assets/apps/calendar.png",
                                              ),
                                              Positioned(
                                                top: cont.smallest.height * .13,
                                                child: Container(
                                                  height:
                                                  cont.maxHeight*0.23,
                                                  width:
                                                  screenWidth(context, mulBy: 0.03),
                                                  //color: Colors.green,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      "${DateFormat('LLL').format(now).toUpperCase()}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "SF",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: cont.smallest.height * .35,
                                                child: Container(
                                                  height:
                                                  cont.maxHeight*0.5,
                                                  width:
                                                  screenWidth(context, mulBy: 0.03),
                                                  //color:Colors.green,

//                                            color: Colors.transparent,
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
                                        );
                                      },)),
                                ),
                                MBPText(
                                    text: "Calendar",
                                    color: Colors.white
                                )
                              ],
                            ),
                          ),
                          LaunchPadItem(
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
                            child: LaunchPadItem(
                              iName: "Feedback",
                              on: fbOpen,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<OnOff>(context, listen: false).onNotifications();
                            },
                            child: LaunchPadItem(
                              iName: "System Preferences",
                              on: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Image.asset(
            "assets/apps/${widget.iName.toLowerCase()}.png",
           // fit: BoxFit.contain,
          ),
        ),
        MBPText(
          text: widget.iName,
            color: Colors.white
        ),
      ],
    );
  }
}