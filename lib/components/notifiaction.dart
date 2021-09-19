import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../sizes.dart';

class Notifications extends StatefulWidget {
  final String notification, url;
  Notifications({Key key, this.notification="", this.url=""}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      //right: ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: Container(
            height: screenHeight(context, mulBy: 0.14),
            width: screenWidth(
              context,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context, mulBy: 0.0025),
                vertical: screenHeight(context, mulBy: 0.003)
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).hoverColor
            ),
          ),

        ),
      ),
    );
  }
}
