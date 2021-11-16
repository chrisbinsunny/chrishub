import 'package:flutter/material.dart';
import 'package:mac_dt/sizes.dart';

class PlatformFinder extends StatelessWidget {
  final Widget iOS;
  final Widget ipadOS;
  final Widget macOS;

  const PlatformFinder({
    Key key,
    @required this.iOS,
    @required this.ipadOS,
    @required this.macOS,
  }) : super(key: key);


  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.aspectRatio < 0.9;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.aspectRatio >= 0.9 &&
          MediaQuery.of(context).size.aspectRatio < 1.7;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.aspectRatio >= 1.7;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.aspectRatio >= 1.7) {
          return macOS;
        }
        else if (MediaQuery.of(context).size.aspectRatio >= 0.9) {
          return ipadOS;
        }
        else {
          return iOS;
        }
      },
    );
  }
}
