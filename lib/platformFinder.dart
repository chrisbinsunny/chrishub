import 'package:flutter/material.dart';
import 'package:mac_dt/sizes.dart';

class Responsive extends StatelessWidget {
  final Widget iOS;
  final Widget ipadOS;
  final Widget macOS;

  const Responsive({
    Key key,
    @required this.iOS,
    @required this.ipadOS,
    @required this.macOS,
  }) : super(key: key);


  static bool isMobile(BuildContext context) =>
      screenWidth(context) < 650;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) < 1100 &&
          screenWidth(context) >= 650;

  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return macOS;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return ipadOS;
        }
        // Or less then that we called it mobile
        else {
          return iOS;
        }
      },
    );
  }
}
