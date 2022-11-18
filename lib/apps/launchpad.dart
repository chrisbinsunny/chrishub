import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/systemPreferences.dart';
import 'package:mac_dt/components/finderWindow.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../components/wallpaper/wallpaper.dart';
import '../system/componentsOnOff.dart';
import '../system/openApps.dart';
import '../providers.dart';
import '../sizes.dart';
import 'about.dart';
import 'calendar.dart';
import 'feedback/feedback.dart';
import 'messages/messages.dart';
import 'safari/safariWindow.dart';
import 'spotify.dart';
import 'terminal/terminal.dart';
import 'vscode.dart';
import 'dart:html' as html;

//TODO Has overflowing error when window is too small


class LaunchPad extends StatefulWidget {
  const LaunchPad({Key? key}) : super(key: key);

  @override
  _LaunchPadState createState() => _LaunchPadState();
}

class _LaunchPadState extends State<LaunchPad> {
  late DateTime now;
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
            ViewWallpaper(location: Provider.of<DataBus>(context, listen: true).getWallpaper.location,),
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
                              LaunchPadItem(
                                iName: "Finder",
                                onTap: () {
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
                              ),

                              LaunchPadItem(
                                iName: "About Me",
                                onTap: () {
                                  tapFunctions(context);
                                  html.window.open('https://drive.google.com/uc?export=download&id=1lPK15gLkNr2Rso3JNr0b-RdmFN245w87', '_self');
                                  Provider.of<OnOff>(context, listen: false)
                                      .maxAbout();
                                  Provider.of<Apps>(context, listen: false).openApp(
                                      About(
                                          key: ObjectKey("about"),
                                          initPos: Offset(
                                              screenWidth(context, mulBy: 0.2),
                                              screenHeight(context, mulBy: 0.12))),
                                      Provider.of<OnOff>(context, listen: false)
                                          .maxAbout()
                                  );
                                },
                              ),
                              LaunchPadItem(
                                iName: "Safari-Mac",
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
                              ),
                              LaunchPadItem(
                                iName: "Messages-Mac",
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false)
                                        .maxMessages();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        Messages(
                                            key: ObjectKey("messages"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.27),
                                                screenHeight(context, mulBy: 0.2))),
                                        Provider.of<OnOff>(context, listen: false)
                                            .maxMessages()
                                    );
                                  });

                                },
                              ),
                              LaunchPadItem(
                                iName: "Maps",
                                onTap: (){
                                  Provider.of<DataBus>(context, listen: false).setNotification(
                                      "App has not been installed. Create the app on GitHub.",
                                      "https://github.com/chrisbinsunny",
                                      "maps",
                                      "Not installed"
                                  );
                                  Provider.of<OnOff>(context, listen: false).onNotifications();
                                },
                              ),
                              LaunchPadItem(
                                iName: "Spotify",
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false)
                                        .maxSpotify();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        Spotify(
                                            key: ObjectKey("spotify"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.24),
                                                screenHeight(context, mulBy: 0.15)
                                            )),
                                        Provider.of<OnOff>(context, listen: false)
                                            .maxSpotify()
                                    );
                                  });
                                },
                              ),
                              LaunchPadItem(
                                iName: "Terminal",
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
                              ),
                              LaunchPadItem(
                                iName: "Visual Studio Code",
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false).maxVS();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        VSCode(
                                            key: ObjectKey("vscode"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.24),
                                                screenHeight(context, mulBy: 0.15))),
                                        Provider.of<OnOff>(context, listen: false).maxVS()
                                    );
                                  });


                                },
                              ),
                              LaunchPadItem(
                                iName: "Photos",
                                onTap: (){
                                  Provider.of<DataBus>(context, listen: false).setNotification(
                                      "App has not been installed. Create the app on GitHub.",
                                      "https://github.com/chrisbinsunny",
                                      "photos",
                                      "Not installed"
                                  );
                                  Provider.of<OnOff>(context, listen: false).onNotifications();
                                },
                              ),
                              LaunchPadItem(
                                iName: "Contacts-Mac",
                                onTap: (){
                                  Provider.of<DataBus>(context, listen: false).setNotification(
                                      "App has not been installed. Create the app on GitHub.",
                                      "https://github.com/chrisbinsunny",
                                      "contacts",
                                      "Not installed"
                                  );
                                  Provider.of<OnOff>(context, listen: false).onNotifications();
                                },
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
                                                screenWidth(context, mulBy: 0.24),
                                                screenHeight(context, mulBy: 0.15)
                                            )
                                        ),
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
                                onTap: (){
                                  Provider.of<DataBus>(context, listen: false).setNotification(
                                      "App has not been installed. Create the app on GitHub.",
                                      "https://github.com/chrisbinsunny",
                                      "notes",
                                      "Not installed"
                                  );
                                  Provider.of<OnOff>(context, listen: false).onNotifications();
                                },
                              ),
                              LaunchPadItem(
                                iName: "Feedback",
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false)
                                        .maxFeedBack();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        FeedBack(
                                            key: ObjectKey("feedback"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.2),
                                                screenHeight(context, mulBy: 0.12))),
                                        Provider.of<OnOff>(context, listen: false)
                                            .maxFeedBack()
                                    );
                                  });

                                },
                              ),
                              LaunchPadItem(
                                iName: "System Preferences",
                                onTap: () {
                                  tapFunctions(context);
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    Provider.of<OnOff>(context, listen: false)
                                        .maxSysPref();
                                    Provider.of<Apps>(context, listen: false).openApp(
                                        SystemPreferences(
                                            key: ObjectKey("systemPreferences"),
                                            initPos: Offset(
                                                screenWidth(context, mulBy: 0.27),
                                                screenHeight(context, mulBy: 0.13))),
                                        Provider.of<OnOff>(context, listen: false)
                                            .maxSysPref()
                                    );
                                  });

                                },
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
  VoidCallback? onTap;
  VoidCallback? onDoubleTap;
  final bool folder;
  LaunchPadItem({
    Key? key,
    required this.iName,
    this.onTap=null,
    this.onDoubleTap=null,
    this.folder=false,
  }) : super(key: key);

  @override
  _LaunchPadItemState createState() => _LaunchPadItemState();
}

class _LaunchPadItemState extends State<LaunchPadItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(
              widget.iName=="About Me"?"assets/icons/server.png":"assets/apps/${widget.iName.toLowerCase()}.png",
              // fit: BoxFit.contain,
            ),
          ),
          MBPText(
            text: widget.iName.split("-")[0],
              color: widget.folder?Theme.of(context).cardColor.withOpacity(1):Colors.white
          ),
        ],
      ),
    );
  }
}