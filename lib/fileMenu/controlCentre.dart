import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componentsOnOff.dart';
import '../sizes.dart';


class ControlCentre extends StatefulWidget {
  const ControlCentre({Key key}) : super(key: key);

  @override
  _ControlCentreState createState() => _ControlCentreState();
}

class _ControlCentreState extends State<ControlCentre> {
  @override
  Widget build(BuildContext context) {
    var ccOpen = Provider.of<OnOff>(context).getCc;
    return ccOpen?Container(
      child: Align(
        alignment: Alignment.topRight,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, mulBy: 0.013),
                  vertical: screenHeight(context, mulBy: 0.025)),
              height: screenHeight(context,mulBy: 0.45),
              width: screenWidth(context, mulBy: 0.2),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
            ),
          ),
        ),
      ),
    ):Container();
  }
}
