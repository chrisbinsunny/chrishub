import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import '../../sizes.dart';
import 'dart:ui' as ui;

//TODO Has an issue with cursor. Currently the issue is present in master branch og flutter.
/// GitHub Issue: https://github.com/flutter/flutter/issues/31661

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
  var commandTECs = <TextEditingController>[];
  var commandCards = <Widget>[];
  DateTime now;

  Widget createCard() {
    var commandController = TextEditingController();
    commandTECs.add(commandController);
    return TerminalCommand(
      commandController: commandController,
      onSubmit: () {
        setState(() {
          commandCards.add(createCard());
        });
      },
    );
  }

  processCommands(String text) {
    var textWords = text.split(' ');
    String command = textWords[0];
    textWords.removeAt(0);
    String variable = text.substring(text.indexOf(' '));
    variable=variable.trim();
    switch (command) {

    }
  }

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    now = DateTime.now();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      commandCards.add(createCard());
    });
  }

  @override
  Widget build(BuildContext context) {
    terminalFS = Provider.of<OnOff>(context).getTerminalFS;
    terminalPan = Provider.of<OnOff>(context).getTerminalPan;
    return AnimatedPositioned(
      duration: Duration(milliseconds: terminalPan ? 0 : 200),
      top: terminalFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
      left: terminalFS ? 0 : position.dx,
      child: terminalWindow(context),
    );
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
                      text:
                          "chrisbin -- -zsh -- ${terminalFS ? screenWidth(context, mulBy: .1).floor() : screenWidth(context, mulBy: 0.04).floor()}x${terminalFS ? screenHeight(context, mulBy: 0.0966).floor() : screenHeight(context, mulBy: 0.05).floor()}",
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
                                .toggleTerminal();
                            Provider.of<OnOff>(context, listen: false)
                                .offTerminalFS();
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
                                .toggleTerminalFS();
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
              child: Container(
                height: screenHeight(context, mulBy: 0.14),
                width: screenWidth(
                  context,
                ),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MBPText(
                      text:
                          "Last login: ${DateFormat("E LLL d hh:mm:ss").format(now)} on console",
                      color: Theme.of(context).cardColor.withOpacity(1),
                      fontFamily: "Menlo",
                      size: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: commandCards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return commandCards[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TerminalCommand extends StatefulWidget {
  final TextEditingController commandController;
  final VoidCallback onSubmit;
  TerminalCommand({Key key, this.commandController, this.onSubmit})
      : super(key: key);

  @override
  _TerminalCommandState createState() => _TerminalCommandState();
}

class _TerminalCommandState extends State<TerminalCommand> {
  bool submit = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            MBPText(
              text: "guest@Chrisbins-MacBook-Pro ~ %",
              color: Theme.of(context).cardColor.withOpacity(1),
              fontFamily: "Menlo",
              size: 10,
            ),
            Expanded(
              child: Container(
                height: 9,
                child: Theme(
                  data: ThemeData(
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Color(0xff9d9d9d),
                    ),
                  ),
                  child: TextField(
                    autofocus: true,
                    enabled: !submit,
                    cursorWidth: 8,
                    cursorHeight: 17,
                    controller: widget.commandController,
                    onSubmitted: (text) {
                      setState(() {
                        widget.onSubmit();
                        submit = true;
                      });
                    },
                    style: TextStyle(
                      color: Theme.of(context).cardColor.withOpacity(1),
                      fontFamily: "Menlo",
                      fontSize: 10,
                      // height: 1,
                    ),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 8, top: 10, bottom: 16)),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Visibility(
          visible: submit,
          child: MBPText(
            text: widget.commandController.text,
            color: Theme.of(context).cardColor.withOpacity(1),
            fontFamily: "Menlo",
            size: 10,
          ),
        ),
      ],
    );
  }
}
