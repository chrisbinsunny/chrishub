import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/launchpad.dart';
import '../apps/calendar.dart';
import 'package:mac_dt/apps/feedback/feedback.dart';
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
            LaunchPadItem(
              iName: "FaceTime",
              onTap: (){
                  Provider.of<DataBus>(context, listen: false).setNotification(
                      "App has not been installed",
                      "",
                      "",
                      "");
              },
            ),
            InkWell(
              onTap: () {
                tapFunctionsIpad(context);
                Provider.of<Apps>(context, listen: false).openIApp(
                  Calendar(
                    key: ObjectKey("calendar"),),
                );
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
                            "assets/appsiOS/calendar.png",
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
                                  "${DateFormat('E').format(now).toUpperCase()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: "SF",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
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
              iName: "Clock",
            ),
            LaunchPadItem(
              iName: "Home",
            ),
            LaunchPadItem(
              iName: "Photos",
            ),
            LaunchPadItem(
              iName: "Camera",
            ),

            LaunchPadItem(
              iName: "Reminders",
            ),
            LaunchPadItem(
              iName: "Notes",
            ),
            LaunchPadItem(
              iName: "Voice Memos",
            ),

            LaunchPadItem(
              iName: "Contacts",
            ),
            LaunchPadItem(
              iName: "Maps",
            ),
            LaunchPadItem(
              iName: "Find My",
            ),

            LaunchPadItem(
              iName: "Appstore",
            ),
            LaunchPadItem(
              iName: "Books",
            ),
            LaunchPadItem(
              iName: "Podcasts",
            ),
            LaunchPadItem(
              iName: "TV",
            ),
            LaunchPadItem(
              iName: "Stocks",
            ),
            LaunchPadItem(
              iName: "Measure",
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

            LaunchPadItem(
              iName: "Spotify",
            ),

            LaunchPadItem(
              iName: "Settings",
            ),
          ],
        ),
    );
  }
}
