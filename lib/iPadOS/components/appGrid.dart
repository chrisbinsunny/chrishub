import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../apps/calendar.dart';
import 'package:mac_dt/apps/feedback/feedback.dart';
import 'package:mac_dt/apps/launchpad.dart';
import 'package:mac_dt/apps/messages/messages.dart';
import 'package:mac_dt/apps/safari/safariWindow.dart';
import 'package:mac_dt/apps/spotify.dart';
import 'package:mac_dt/apps/terminal/terminal.dart';
import 'package:mac_dt/apps/vscode.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/system/openApps.dart';
import 'package:provider/provider.dart';

import '../../providers.dart';
import '../../sizes.dart';
import '../../widgets.dart';


class AppMenu extends StatefulWidget {
  const AppMenu({Key key}) : super(key: key);

  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  DateTime now;

  void initState() {
    now = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight(context, mulBy: 0.1)
      ),
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
    );
  }
}
