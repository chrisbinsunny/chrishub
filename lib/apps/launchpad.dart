import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/components/finderWindow.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../system/componentsOnOff.dart';
import '../system/openApps.dart';
import '../providers.dart';
import '../sizes.dart';
import 'calendar.dart';
import 'feedback/feedback.dart';
import 'messages/messages.dart';
import 'safari/safariWindow.dart';
import 'spotify.dart';
import 'terminal/terminal.dart';
import 'vscode.dart';

//TODO Has overflowing error when window is too small


class LaunchPad extends StatefulWidget {
  const LaunchPad({Key key}) : super(key: key);

  @override
  _LaunchPadState createState() => _LaunchPadState();
}

class _LaunchPadState extends State<LaunchPad> {
  DateTime now;
  bool _animate = false;
  TextEditingController controller= new TextEditingController();
  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool launchPadOpen= Provider.of<OnOff>(context).getLaunchPad;
    return IgnorePointer(
      ignoring: !launchPadOpen,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 150),
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
                child: InkWell(
                  mouseCursor: MouseCursor.defer,
                  onTap: (){
                    Provider.of<OnOff>(context, listen: false).offLaunchPad();
                  },
                  child: Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    padding: EdgeInsets.only(
                        left: screenWidth(context, mulBy: 0.12),
                      right: screenWidth(context, mulBy: 0.12),
                      bottom: screenHeight(context, mulBy: 0.17),
                      top: screenHeight(context, mulBy: 0.06)
                    ),
                    color: Colors.black.withOpacity(0.15),
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 150),
                      scale: launchPadOpen?1:1.1,
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight(context, mulBy: 0.035),
                            width: screenWidth(context, mulBy: 0.17),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2)
                              )
                            ),

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(
                                 Icons.search,
                                 size: 14,
                                 color: Colors.white.withOpacity(0.7),
                               ),
                               SizedBox(
                                 width: screenWidth(context, mulBy: 0.0035),
                               ),
                               MBPText(
                                 text: "Search",
                                 color: Colors.white.withOpacity(0.3),
                                 weight: FontWeight.w200,
                               )
                             ],
                           ),
                          ),
                          Spacer(flex: 1,),
                          GridView(
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
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });

                                },
                                child: LaunchPadItem(
                                  iName: "Finder",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });

                                },
                                child: LaunchPadItem(
                                  iName: "Safari",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });

                                },
                                child: LaunchPadItem(
                                  iName: "Messages",
                                ),
                              ),
                              LaunchPadItem(
                                iName: "Maps",
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });
                                },
                                child: LaunchPadItem(
                                  iName: "Spotify",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });


                                },
                                child: LaunchPadItem(
                                  iName: "Terminal",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false).maxVS();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        VSCode(
                                            key: ObjectKey("vscode"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.14),
                                                screenHeight(context, mulBy: 0.1))),
                                        Provider.of<OnOff>(context, listen: false).maxVS()
                                    );
                                  });


                                },
                                child: LaunchPadItem(
                                  iName: "Visual Studio Code",
                                ),
                              ),
                              LaunchPadItem(
                                iName: "Photos",
                              ),
                              LaunchPadItem(
                                iName: "Contacts",
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });


                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      ///For setting the Text on the icon on position. Done by getting relative position.
                                      child: LayoutBuilder(builder: (context, cont) {
                                        return Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Image.asset(
                                              "assets/appsMac/calendar-Mac.png",
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
                                        );
                                      },),
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
                              ),
                              InkWell(
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
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
                                  });

                                },
                                child: LaunchPadItem(
                                  iName: "Feedback",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<OnOff>(context, listen: false).onNotifications();
                                },
                                child: LaunchPadItem(
                                  iName: "System Preferences",
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 3,),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LaunchPadItem extends StatefulWidget {
  final String iName;
  VoidCallback onTap;
  LaunchPadItem({
    Key key,
    @required this.iName,
    @required this.onTap
  }) : super(key: key);

  @override
  _LaunchPadItemState createState() => _LaunchPadItemState();
}

class _LaunchPadItemState extends State<LaunchPadItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
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
      ),
    );
  }
}