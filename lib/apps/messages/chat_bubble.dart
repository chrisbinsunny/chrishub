import 'package:flutter/material.dart';

import 'clipper.dart';
import 'types.dart';

class ChatBubble extends StatelessWidget {
  final CustomClipper clipper;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final Color backGroundColor;
  final Color shadowColor;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  ChatBubble({
    this.clipper,
    this.child,
    this.margin,
    this.elevation,
    this.backGroundColor,
    this.shadowColor,
    this.alignment,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      margin: margin ?? EdgeInsets.all(0),
      child: PhysicalShape(
        clipper: clipper as CustomClipper<Path>,
        color: backGroundColor ?? Colors.blue,
        child: Padding(
          padding: padding ?? setPadding(),
          child: child ?? Container(),
        ),
      ),
    );
  }

  EdgeInsets setPadding() {
    if (clipper is iMessageClipper) {
      if ((clipper as iMessageClipper).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 16);
      } else {
        return EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 10);
      }
    }

    return EdgeInsets.all(10);
  }
}

