import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'types.dart';


class iMessageClipper extends CustomClipper<Path> {
  final BubbleType type;
  final double radius;
  final double nipSize;

  iMessageClipper({this.type, this.radius = 13, this.nipSize = 4});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (type == BubbleType.sendBubble) {
      path.moveTo(radius, 0);
      path.lineTo(size.width - radius - nipSize, 0);
      path.arcToPoint(Offset(size.width - nipSize, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width - nipSize, size.height - nipSize);

      path.arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(nipSize), clockwise: false);

      path.arcToPoint(Offset(size.width - 2 * nipSize, size.height - nipSize),
          radius: Radius.circular(2 * nipSize));

      path.arcToPoint(Offset(size.width - 4 * nipSize, size.height),
          radius: Radius.circular(2 * nipSize));

      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.moveTo(radius, 0);
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width, size.height - radius);

      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));

      path.lineTo(4 * nipSize, size.height);
      path.arcToPoint(Offset(2 * nipSize, size.height - nipSize),
          radius: Radius.circular(2 * nipSize));

      path.arcToPoint(Offset(0, size.height),
          radius: Radius.circular(2 * nipSize));

      path.arcToPoint(Offset(nipSize, size.height - nipSize),
          radius: Radius.circular(nipSize), clockwise: false);

      path.lineTo(nipSize, radius);
      path.arcToPoint(Offset(radius + nipSize, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

