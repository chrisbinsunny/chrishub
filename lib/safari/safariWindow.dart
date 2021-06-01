import 'package:flutter/material.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../components/windowWidgets.dart';
import '../sizes.dart';
import '../widgets.dart';
import 'dart:ui';

class Safari extends StatefulWidget {
  final Offset initPos;
  const Safari({this.initPos, Key key}) : super(key: key);

  @override
  _SafariState createState() => _SafariState();
}

class _SafariState extends State<Safari> {
  Offset position = Offset(0.0, 0.0);
  String selected = "Applications";
  bool safariFS;
  bool safariPan;

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var safariOpen = Provider.of<OnOff>(context).getSafari;
    safariFS = Provider.of<OnOff>(context).getSafariFS;
    safariPan = Provider.of<OnOff>(context).getSafariPan;
    return safariOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: safariPan ? 0 : 200),
            top: safariFS ? screenHeight(context, mulBy: 0.035) : position.dy,
            left: safariFS ? 0 : position.dx,
            child: safariWindow(context),
          )
        : Container();
  }

  AnimatedContainer safariWindow(BuildContext context) {
    String thm = Provider.of<ThemeNotifier>(context).findThm;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: safariFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: safariFS
          ? screenHeight(context, mulBy: 0.863)
          : screenHeight(context, mulBy: 0.65),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, mulBy: 0.013),
                    vertical: screenHeight(context, mulBy: 0.01)),
                height: screenHeight(context,mulBy: 0.059),
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleSafari();
                            Provider.of<OnOff>(context, listen: false)
                                .offSafariFS();
                          },
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
                          child: Container(
                            height: 11.5,
                            width: 11.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<OnOff>(context, listen: false)
                                .toggleSafariFS();
                          },
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 300,
                      height: screenHeight(context,mulBy: 0.03),//0.038
                      margin: EdgeInsets.zero,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Search or enter website name",
                          labelStyle: TextStyle(
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                            fontFamily: "SF",
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                          ),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide: new BorderSide(
                              color: Colors.transparent
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),

                  ],
                ),
              ),
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  if (!safariFS) {
                    setState(() {
                      position = Offset(position.dx + tapInfo.delta.dx,
                          position.dy + tapInfo.delta.dy);
                    });
                  }
                },
                onPanStart: (details) {
                  Provider.of<OnOff>(context, listen: false).onSafariPan();
                },
                onPanEnd: (details) {
                  Provider.of<OnOff>(context, listen: false).offSafariPan();
                },
                onDoubleTap: () {
                  Provider.of<OnOff>(context, listen: false).toggleSafariFS();
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    width: safariFS
                        ? screenWidth(context, mulBy: 0.95)
                        : screenWidth(context, mulBy: 0.5),
                    height: screenHeight(context, mulBy: 0.058),
                    color: Colors.transparent),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, mulBy: 0.013),
                      vertical: screenHeight(context, mulBy: 0.025)),
                  height: screenHeight(context, mulBy: 0.14),
                  width: screenWidth(
                    context,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
