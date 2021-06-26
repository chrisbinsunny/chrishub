import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import '../../sizes.dart';
import 'dart:ui' as ui;

class Terminal extends StatefulWidget {
  final Offset initPos;
  const Terminal({this.initPos, Key key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  Offset position = Offset(0.0, 0.0);
  bool terminalFS;
  bool terminalPan;

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var terminalOpen = Provider.of<OnOff>(context).getTerminal;
    terminalFS = Provider.of<OnOff>(context).getTerminalFS;
    terminalPan = Provider.of<OnOff>(context).getTerminalPan;
    return terminalOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: terminalPan ? 0 : 200),
            top: terminalFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
            left: terminalFS ? 0 : position.dx,
            child: terminalWindow(context),
          )
        : Container();
  }

  AnimatedContainer terminalWindow(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: terminalFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.4),
      height: terminalFS
          ? screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        color: Theme.of(context).dialogBackgroundColor,
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
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: terminalFS
                    ? screenHeight(context, mulBy: 0.04)
                    : screenHeight(context, mulBy: 0.04),
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MBPText(
                      text: "chrisbin -- -zsh -- ${terminalFS
                          ? screenWidth(context, mulBy: .1).floor()
                          : screenWidth(context, mulBy: 0.04).floor()}x${terminalFS
                          ? screenHeight(context, mulBy: 0.0966).floor()
                          : screenHeight(context, mulBy: 0.05).floor()}",
                      fontFamily: "HN",
                      color: Theme.of(context).cardColor.withOpacity(1),
                      weight: Theme.of(context).textTheme.headline4.fontWeight,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onPanUpdate: (tapInfo) {
                  if (!terminalFS) {
                    setState(() {
                      position = Offset(position.dx + tapInfo.delta.dx,
                          position.dy + tapInfo.delta.dy);
                    });
                  }
                },
                onPanStart: (details) {
                  Provider.of<OnOff>(context, listen: false).onTerminalPan();
                },
                onPanEnd: (details) {
                  Provider.of<OnOff>(context, listen: false).offTerminalPan();
                },
                onDoubleTap: () {
                  Provider.of<OnOff>(context, listen: false).toggleTerminalFS();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  width: terminalFS
                      ? screenWidth(context, mulBy: 0.95)
                      : screenWidth(context, mulBy: 0.7),
                  height: terminalFS
                      ? screenHeight(context, mulBy: 0.04)
                      : screenHeight(context, mulBy: 0.04),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black.withOpacity(0.9),
                              width: 0.2))),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, mulBy: 0.013),
                    vertical: screenHeight(context, mulBy: 0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                .toggleVS();
                            Provider.of<OnOff>(context, listen: false)
                                .offVSFS();
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
                                .toggleVSFS();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  height: screenHeight(context, mulBy: 0.14),
                  width: screenWidth(
                    context,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 6,
                    vertical: 5
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  child: Expanded(
                    child: Container(
                      color: Colors.green,
                    ),
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
