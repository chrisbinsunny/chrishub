import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/apps/launchpad.dart';
import 'package:mac_dt/iPadOS/apps/feedback/feedback.dart';
import 'package:mac_dt/iPadOS/apps/spotify.dart';
import '../apps/calendar.dart';
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
                      "FaceTime",
                      "FaceTime");
                  Provider.of<OnOff>(context, listen: false).onNotifications();
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
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Clock",
                    "Clock");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Home",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Home",
                    "Home");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Photos",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Photos",
                    "Photos");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Camera",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Camera",
                    "Camera");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),

            LaunchPadItem(
              iName: "Reminders",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Reminders",
                    "Reminders");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Notes",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Notes",
                    "Notes");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Voice Memos",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Voice Memos",
                    "Voice Memos");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),

            LaunchPadItem(
              iName: "Contacts",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Contacts",
                    "Contacts");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Maps",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Maps",
                    "Maps");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Find My",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Find My",
                    "Find My");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),

            LaunchPadItem(
              iName: "Appstore",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Appstore",
                    "Appstore");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Books",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Books",
                    "Books");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Podcasts",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Podcasts",
                    "Podcasts");
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "TV",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "TV",
                  "TV",);
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Stocks",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Stocks",
                  "Stocks",);
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Measure",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Measure",
                  "Measure",);
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
                  Provider.of<Apps>(context, listen: false).openIApp(
                      FeedBack(
                          key: ObjectKey("feedback"),),
                  );
                });

              },
            ),

            LaunchPadItem(
              iName: "Spotify",
              onTap: () {
                tapFunctionsIpad(context);
                Provider.of<Apps>(context, listen: false).openIApp(
                  Spotify(
                    key: ObjectKey("spotify"),),
                );
              },
            ),

            LaunchPadItem(
              iName: "Settings",
              onTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed",
                    "",
                    "Settings",
                  "Settings",);
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
          ],
        ),
    );
  }
}
