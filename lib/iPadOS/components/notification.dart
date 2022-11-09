import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../sizes.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key, }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var themeNotifier;
  late Map<String, String> notification;
  bool notificationOn=false;
  bool hover=false;
  @override
  Widget build(BuildContext context) {
    themeNotifier = Provider.of<ThemeNotifier>(context);
    notification = Provider.of<DataBus>(context).getNotification;
    notificationOn = Provider.of<OnOff>(context).getNotificationOn;
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
      left: screenWidth(context, mulBy: 0.315),
      top: notificationOn?screenHeight(context, mulBy: 0.03):-screenHeight(context, mulBy: 0.08),
      child: Container(
        width: screenWidth(context, mulBy: 0.37),
        height: screenHeight(context, mulBy: 0.07),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
                padding: EdgeInsets.only(
                    left: screenWidth(context, mulBy: 0.005),
                    right: screenWidth(context, mulBy: 0.01),
                    top: screenHeight(context, mulBy: 0.01),
                    bottom: screenHeight(context, mulBy: 0.01)
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).selectedRowColor
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/apps/${notification["app"]}.png",
                    ),
                    SizedBox(
                      width: screenWidth(context, mulBy: 0.01),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MBPText(
                            text: notification["head"],
                            color: Theme.of(context).cardColor.withOpacity(1),
                            size: 10.5,
                            weight: Theme.of(context).textTheme.headline3!.fontWeight,
                            maxLines: 1,
                          ),
                          MBPText(
                            text: notification["notification"],
                            color: Theme.of(context).cardColor.withOpacity(1),
                            size: 10.5,
                            weight: Theme.of(context).textTheme.headline2!.fontWeight,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    MBPText(text: "now",
                      color: Theme.of(context).cardColor.withOpacity(.5),
                      size: 10,
                    )
                  ],
                )
            ),

          ),
        ),
      ),
    );
  }
}
