import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'theme/theme.dart';
import 'package:provider/provider.dart';
import '../openApps.dart';
import '../sizes.dart';
import '../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class RightClick extends StatefulWidget {
  final Offset initPos;
  const RightClick({this.initPos, Key key}) : super(key: key);

  @override
  _RightClickState createState() => _RightClickState();
}

class _RightClickState extends State<RightClick> {
  Offset position = Offset(0.0, 0.0);
  var themeNotifier;

  Offset QFinder(){
    Offset offset=new Offset(0, 0);
    if(widget.initPos.dx+screenWidth(context, mulBy: 0.15)+1>=screenWidth(context))
      {
        if(widget.initPos.dy+screenHeight(context, mulBy: 0.3)+1>=screenHeight(context)) {
          offset =
              widget.initPos - Offset(screenWidth(context, mulBy: 0.15) + 1, 0);
          offset = Offset(offset.dx, screenHeight(context, mulBy: 0.7) - 1);
        }
        else
          offset=widget.initPos-Offset(screenWidth(context, mulBy: 0.15)+1,0);
      }
    else{
      if(widget.initPos.dy+screenHeight(context, mulBy: 0.3)+1>=screenHeight(context)) {
        offset = Offset(widget.initPos.dx, screenHeight(context, mulBy: 0.7) - 1);
      }
      else
        offset=widget.initPos;
    }
    return offset;
  }

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rcmOpen = Provider.of<OnOff>(context).getRCM;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Visibility(
      visible: rcmOpen,
          child: Positioned(
      top: QFinder().dy,
      left:  QFinder().dx,
      child: RightClickMenu(context),
    ),
        );
  }

  AnimatedContainer RightClickMenu(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: screenWidth(context, mulBy: 0.15)+1,
      height: screenHeight(context, mulBy: 0.2)+1,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).shadowColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        width: screenWidth(context, mulBy: 0.15),
        height: screenHeight(context, mulBy: 0.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: themeNotifier.isDark()?0.6:0
          ),

        ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RCMItem(
                    name: "New Folder",
                    margin: EdgeInsets.only(
                      bottom: screenHeight(context, mulBy: 0.006)
                    ),
                    buttonFunc: (){
                      print("New Folder Created");
                    },
                  ),
                  Container(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.9),
                    height: 0.25,
                    width: screenWidth(context,
                        mulBy: 0.13),
                  ),
                  RCMItem(
                    name: "Get Info",
                    margin: EdgeInsets.only(
                        top: screenHeight(context, mulBy: 0.006)
                    ),
                  ),
                  RCMItem(
                    name: "Change Desktop Background...",
                    margin: EdgeInsets.only(
                        bottom: screenHeight(context, mulBy: 0.006)
                    ),
                  ),
                  Container(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.9),
                    height: 0.25,
                    width: screenWidth(context,
                        mulBy: 0.13),
                  ),
                  RCMItem(
                    name: "Use Stacks",
                    margin: EdgeInsets.only(
                        top: screenHeight(context, mulBy: 0.006)
                    ),
                  ),
                  RCMItem(
                    name: "Group Stacks By",
                  ),
                  RCMItem(
                    name: "Show View Options",
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}

class RCMItem extends StatefulWidget {
  final String name;
  final EdgeInsets margin;
  VoidCallback buttonFunc=(){};

  RCMItem({
    Key key,
    this.name,
    this.margin=EdgeInsets.zero,
    this.buttonFunc,
  }) : super(key: key);

  @override
  _RCMItemState createState() => _RCMItemState();
}

class _RCMItemState extends State<RCMItem> {
  Color color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event){
        setState(() {
          color= Colors.blue;
        });
      },
      onExit: (event){
        setState(() {
          color= Colors.transparent;
        });
      },
      child: InkWell(
        onTap: widget.buttonFunc,
        child: Container(
          height: screenHeight(context, mulBy: 0.0275),
          width: screenWidth(context),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
              left: screenWidth(context, mulBy: 0.0125),
          ),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3)
          ),
          child: MBPText(
            text: widget.name,
            color: Theme.of(context).cardColor.withOpacity(1),
            fontFamily: 'SF',
            size: 12.5,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class BrdrContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const BrdrContainer({this.height = 1, this.width = 1, this.child, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, mulBy: height) + 1,
      width: screenWidth(context, mulBy: width) + 1,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(0.00),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).shadowColor, width: 1),
      ),
      child: child,
    );
  }
}