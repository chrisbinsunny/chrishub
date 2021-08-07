import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../openApps.dart';
import '../sizes.dart';
import '../widgets.dart';

class Messages extends StatefulWidget {
  final Offset initPos;
  const Messages({this.initPos, Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Offset position = Offset(0.0, 0.0);
  bool messagesFS;
  bool messagesPan;

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var messagesOpen = Provider.of<OnOff>(context).getMessages;
    messagesFS = Provider.of<OnOff>(context).getMessagesFS;
    messagesPan = Provider.of<OnOff>(context).getMessagesPan;
    return messagesOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: messagesPan ? 0 : 200),
            top: messagesFS ? screenHeight(context, mulBy: 0.034) : position.dy,
            left: messagesFS ? 0 : position.dx,
            child: messagesWindow(context),
          )
        : Container();
  }

  AnimatedContainer messagesWindow(BuildContext context) {
    String thm = Provider.of<ThemeNotifier>(context).findThm;
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: messagesFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: messagesFS
          ? screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.65),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.005),
                        vertical: screenHeight(context, mulBy: 0.025)),
                    height: screenHeight(context),
                    width: screenWidth(context, mulBy: 0.2),
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, mulBy: 0.008),
                              ),
                          child: Row(
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
                                      .offFinderFS();
                                  Provider.of<Apps>(context, listen: false)
                                      .closeApp("finder");
                                  Provider.of<OnOff>(context, listen: false)
                                      .toggleFinder();
                                },
                              ),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.005),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<OnOff>(context, listen: false)
                                      .toggleFinder();
                                  Provider.of<OnOff>(context, listen: false)
                                      .offFinderFS();
                                },
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
                                      .toggleFinderFS();
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.028),
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.035),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, mulBy: 0.005)
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Theme.of(context).cardColor.withOpacity(0.15),
                              width: 0.5
                            )
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icons/spotlight.png", height: 12, color: Theme.of(context).cardColor.withOpacity(0.3),),
                                  SizedBox(width: screenWidth(context, mulBy: 0.002),),
                                  MBPText(text: "Search", color: Theme.of(context).cardColor.withOpacity(0.3),fontFamily: 'HN')
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.013),
                        vertical: screenHeight(context, mulBy: 0.03)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                          left: BorderSide(color: Colors.black, width: 0.8)),
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!messagesFS) {
                setState(() {
                  position = Offset(position.dx + tapInfo.delta.dx,
                      position.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onMessagesPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offMessagesPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleMessagesFS();
            },
            child: Container(
                alignment: Alignment.centerRight,
                width: messagesFS
                    ? screenWidth(context, mulBy: 0.95)
                    : screenWidth(context, mulBy: 0.5),
                height: screenHeight(context, mulBy: 0.04),
                color: Colors.transparent),
          ),
          Visibility(
            visible: topApp != "Messages",
            child: InkWell(
              onTap: () {
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("messages"));
              },
              child: Container(
                width: screenWidth(
                  context,
                ),
                height: screenHeight(
                  context,
                ),
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
