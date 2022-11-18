import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;



class About extends StatefulWidget {
  final Offset? initPos;
  const About({this.initPos, Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Offset? position = Offset(0.0, 0.0);
  late bool aboutFS;
  late bool aboutPan;
  late bool aboutOpen;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    aboutOpen = Provider.of<OnOff>(context).getFeedBack;
    aboutFS = Provider.of<OnOff>(context).getFeedBackFS;
    aboutPan = Provider.of<OnOff>(context).getFeedBackPan;
    return aboutOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: aboutPan ? 0 : 200),
            top:
                aboutFS ? screenHeight(context, mulBy: 0.0335) : position!.dy,
            left: aboutFS ? 0 : position!.dx,
            child: aboutWindow(context),
          )
        : Container();
  }

  AnimatedContainer aboutWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: aboutFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.58),
      height: aboutFS
          ?screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.7),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).dialogBackgroundColor,
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
        alignment: Alignment.topCenter,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    //width: screenWidth(context, mulBy: feedbackFS ? .5 : .35),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        border: Border(
                            right: BorderSide(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.3),
                                width: 0.6))),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.025),
                        vertical: screenHeight(context, mulBy: 0.05)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.02),
                          vertical: screenHeight(context, mulBy: 0.05)),
                      duration: Duration(milliseconds: 200),
                      width: screenWidth(context, mulBy: aboutFS ? .79 : .46),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: screenHeight(context,
                                mulBy: aboutFS ? 0.40 : .25),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/apps/feedback.png",
                                  height: 100,
                                  // width: 30,
                                ),
                                MBPText(
                                  text: "Chrisbin's MacBook Pro Feedback",
                                  size: 25,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!aboutFS) {
                setState(() {
                  position = Offset(position!.dx + tapInfo.delta.dx,
                      position!.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onFeedBackPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offFeedBackPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleFeedBackFS();
            },
            child: Container(
              alignment: Alignment.topRight,
              width: aboutFS
                  ? screenWidth(context, mulBy: 0.95)
                  : screenWidth(context, mulBy: 0.7),
              height: aboutFS
                  ? screenHeight(context, mulBy: 0.059)
                  : screenHeight(context, mulBy: 0.06),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context, mulBy: 0.013),
                vertical: screenHeight(context, mulBy: 0.02)),
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
                    Provider.of<OnOff>(context, listen: false).toggleFeedBack();
                    Provider.of<OnOff>(context, listen: false).offFeedBackFS();
                    Provider.of<Apps>(context, listen: false).closeApp("feedback");
                  },
                ),
                SizedBox(
                  width: screenWidth(context, mulBy: 0.005),
                ),
                InkWell(
                  onTap: (){
                    Provider.of<OnOff>(context, listen: false).toggleFeedBack();
                    Provider.of<OnOff>(context, listen: false).offFeedBackFS();
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
                        .toggleFeedBackFS();
                  },
                )
              ],
            ),
          ),


    Visibility(
    visible: topApp != "About",
    child: InkWell(
    onTap: (){
    Provider.of<Apps>(context, listen: false)
        .bringToTop(ObjectKey("about"));
    },
    child: Container(
    width: screenWidth(context,),
    height: screenHeight(context,),
    color: Colors.transparent,
    ),
    ),
    ),
        ],
      ),
    );
  }
}
