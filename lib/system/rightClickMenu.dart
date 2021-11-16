import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/system/folders.dart';
import '../theme/theme.dart';
import 'package:provider/provider.dart';
import 'openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
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
            color: Colors.grey.withOpacity(0.9),
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
                      Provider.of<Folders>(context, listen: false).createFolder(context, renaming: true);
                      Provider.of<OnOff>(context, listen: false).offRCM();
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
                    buttonFunc: (){
                      print("Get Info Screen");
                      Provider.of<OnOff>(context, listen: false).offRCM();
                    },
                  ),
                  RCMItem(
                    name: "Change Desktop Background...",
                    margin: EdgeInsets.only(
                        bottom: screenHeight(context, mulBy: 0.006)
                    ),
                    buttonFunc: (){
                      print("Settings Screen");
                      Provider.of<OnOff>(context, listen: false).offRCM();
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
  bool folder;
  bool icon;

  RCMItem({
    Key key,
    this.name,
    this.margin=EdgeInsets.zero,
    this.buttonFunc,
    this.folder=false,
    this.icon=false
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
          color= Color(0xff1a6cc4);
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
              left: screenWidth(context, mulBy: widget.folder?0.004:0.0125),
            right: screenWidth(context, mulBy: 0.006),

          ),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3)
          ),
          child: Row(
            children: [
              MBPText(
                text: widget.name,
                color: Theme.of(context).cardColor.withOpacity(1),
                fontFamily: 'SF',
                size: 12.5,
                weight: FontWeight.w400,
              ),
              Visibility(
                  visible: widget.icon,
                  child: Spacer()),
              Visibility(
                visible: widget.icon,
                  child: Icon(CupertinoIcons.forward, color: Theme.of(context).cardColor.withOpacity(1), size: 12.5,))
            ],
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


class FolderRightClick extends StatefulWidget {
  final Offset initPos;
  const FolderRightClick({this.initPos, Key key}) : super(key: key);

  @override
  _FolderRightClickState createState() => _FolderRightClickState();
}

class _FolderRightClickState extends State<FolderRightClick> {
  Offset position = Offset(0.0, 0.0);
  var themeNotifier;

  Offset QFinder(){
    Offset offset=new Offset(0, 0);
    if(widget.initPos.dx+screenWidth(context, mulBy: 0.15)+1>=screenWidth(context))
    {
      if(widget.initPos.dy+screenHeight(context, mulBy: 0.73)+1>=screenHeight(context)) {
        offset =
            widget.initPos - Offset(screenWidth(context, mulBy: 0.15) + 1, 0);
        offset = Offset(offset.dx, screenHeight(context, mulBy: 0.27) - 1);
      }
      else
        offset=widget.initPos-Offset(screenWidth(context, mulBy: 0.15)+1,0);
    }
    else{
      if(widget.initPos.dy+screenHeight(context, mulBy: 0.73)+1>=screenHeight(context)) {
        offset = Offset(widget.initPos.dx, screenHeight(context, mulBy: 0.27) - 1);
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
    var frcmOpen = Provider.of<OnOff>(context).getFRCM;
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return Visibility(
      visible: frcmOpen,
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
      height: screenHeight(context, mulBy: 0.54)+1,
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
        height: screenHeight(context, mulBy: 0.54),
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
                    name: "Open",
                    folder: true,
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
                        mulBy: 0.14),
                  ),
                  RCMItem(
                    folder: true,
                    name: "Move to Bin",
                    margin: EdgeInsets.only(
                        top: screenHeight(context, mulBy: 0.006),
                        bottom: screenHeight(context, mulBy: 0.006)
                    ),
                    buttonFunc: (){
                      Provider.of<Folders>(context, listen: false).deleteFolder(context);
                      Provider.of<OnOff>(context, listen: false).offFRCM();
                    },
                  ),
                  Container(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.9),
                    height: 0.25,
                    width: screenWidth(context,
                        mulBy: 0.14),
                  ),
                  RCMItem(
                    folder: true,

                    name: "Get Info",
                    margin: EdgeInsets.only(
                        top: screenHeight(context, mulBy: 0.006)
                    ),
                  ),
                  RCMItem(
                    folder: true,
                    name: "Rename",
                    buttonFunc: (){
                      Provider.of<Folders>(context, listen: false).renameFolder();
                      Provider.of<OnOff>(context, listen: false).offFRCM();
                    },
                  ),
                  RCMItem(
                    folder: true,

                    name: "Compress",
                  ),

                  RCMItem(
                    folder: true,

                    name: "Duplicate",
                  ),
                  RCMItem(
                    folder: true,

                    name: "Make Alias",
                  ),
                  RCMItem(
                    folder: true,

                    name: "Quick Look",
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
                        mulBy: 0.14),
                  ),
                  RCMItem(
                    folder: true,

                    name: "Copy",
                    margin: EdgeInsets.only(
                        top: screenHeight(context, mulBy: 0.006)
                    ),
                  ),
                  RCMItem(
                    folder: true,
                    icon: true,
                    name: "Share",
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
                        mulBy: 0.14),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.006),
                      vertical: screenHeight(context, mulBy: 0.009)
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.redAccent
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amberAccent
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),

                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),

                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.004),
                        ),
                        Container(
                          height: screenHeight(context, mulBy: 0.018),
                          width: screenHeight(context, mulBy: 0.018),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70
                          ),
                        ),
                      ],
                    ),
                  ),
                  RCMItem(
                    folder: true,
                    name: "Tags...",
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
                        mulBy: 0.14),
                  ),
                  RCMItem(
                    folder: true,
                    icon: true,
                    name: "Quick Actions",
                    margin: EdgeInsets.only(
                      bottom: screenHeight(context, mulBy: 0.006),
                      top: screenHeight(context, mulBy: 0.006),
                    ),
                  ),
                  Container(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.9),
                    height: 0.25,
                    width: screenWidth(context,
                        mulBy: 0.14),
                  ),
                  RCMItem(
                    folder: true,

                    name: "Folder Actions Setup...",
                    margin: EdgeInsets.only(
                      top: screenHeight(context, mulBy: 0.006),
                    ),
                  ),
                  RCMItem(
                    folder: true,

                    name: "New Terminal at Folder",
                  ),
                  RCMItem(
                    folder: true,

                    name: "New Terminal Tab at Folder",
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

