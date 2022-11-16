import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

import '../sizes.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key, }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late var themeNotifier;
  late Map<String, String> notification;
  bool notificationOn=false;
  bool hover=false;
  @override
  Widget build(BuildContext context) {
    themeNotifier = Provider.of<ThemeNotifier>(context);
    notification = Provider.of<DataBus>(context).getNotification;
    notificationOn = Provider.of<OnOff>(context).getNotificationOn;
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      right: notificationOn?screenWidth(context, mulBy: 0.01):-screenWidth(context, mulBy: 0.201),
      top: screenHeight(context, mulBy: 0.055),
      child: MouseRegion(
        onExit: (p){
          setState(() {
            hover=false;
          });
        },
        onEnter: (p){
          setState(() {
            hover=true;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: (){
                html.window.open(notification["url"]!, 'new tab');
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 270.5,
                height: 75.5,
                constraints: BoxConstraints(
                    minHeight: 80
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).shadowColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  width: 270,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.9),
                        width: themeNotifier.isDark()?0.5:0
                    ),

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                      child: Container(
                        height: screenHeight(context, mulBy: 0.14),
                        width: screenWidth(
                          context,
                        ),

                        padding: EdgeInsets.only(
                            left: screenWidth(context, mulBy: 0.005),
                            right: screenWidth(context, mulBy: 0.01),
                            top: screenHeight(context, mulBy: 0.007),
                            bottom: screenHeight(context, mulBy: 0.01)
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).focusColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenHeight(context, mulBy: 0.027),
                                  child: Image.asset(
                                    "assets/appsMac/${notification["app"]}.png",
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                MBPText(
                                  text: notification["app"]!.toUpperCase(),
                                  color: Theme.of(context).cardColor.withOpacity(0.5),
                                  size: 11,
                                  fontFamily: "SF",
                                ),
                                Spacer(),
                                Center(
                                  child: MBPText(text: "now",
                                    color: Theme.of(context).cardColor.withOpacity(1),
                                    size: 11,
                                  ),
                                )
                              ],
                            ),

                            Text(
                              notification["head"]!,
                              style: TextStyle(
                                color: Theme.of(context).cardColor.withOpacity(1),
                                fontSize: 11.5,
                                fontWeight: Theme.of(context).textTheme.headline3!.fontWeight,
                              ),
                              maxLines: 1,
                            ),
                            MBPText(
                              text: notification["notification"],
                              color: Theme.of(context).cardColor.withOpacity(1),
                              size: 11.5,
                              weight: Theme.of(context).textTheme.headline2!.fontWeight,
                              maxLines: 1,
                            ),
                          ],
                        )
                      ),

                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: hover,
              child: Positioned(
                left: -screenHeight(context, mulBy: 0.007),
                top: -screenHeight(context, mulBy: 0.007),
                child: InkWell(
                  onTap: (){
                    Provider.of<OnOff>(context, listen: false).offNotifications();
                  },
                  child: Container(
                    height: screenHeight(context, mulBy: 0.025)+0.7,
                    width: screenHeight(context, mulBy: 0.025)+0.7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).shadowColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      height: screenHeight(context, mulBy: 0.025),
                      width: screenHeight(context, mulBy: 0.025),
                      decoration: BoxDecoration(
    shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.9),
                            width: themeNotifier.isDark()?0.7:0
                        ),

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                          child: Container(
                              height: screenHeight(context, mulBy: 0.025),
                              width: screenHeight(context, mulBy: 0.025),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                shape: BoxShape.circle,

                              ),
                            child: Icon(
                              CupertinoIcons.clear,
                              color: Theme.of(context).cardColor.withOpacity(.8),
                              size: 10,
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
