import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import '../../sizes.dart';
import 'dart:ui' as ui;

import 'commands.dart';

//TODO Has an issue with cursor. Currently the issue is present in master branch og flutter.
/// GitHub Issue: https://github.com/flutter/flutter/issues/31661

//TODO Clear command not working

String output = "";
String directory = "/~";

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
  var oldCommands = <String>[""];
  var commandCards = <Widget>[];
  DateTime now;
  int updownIndex = 0;
  String currentDir = "~";
  Map<String, List<String>> contents = {
    "~": [
      "applications",
      "documents",
      "downloads",
      "library",
      "movies",
      "music",
      "pictures",
      "public"
    ],
    "library": [
      "One Night at a call centre",
    ],
    "skills": ["Front-end development", "jQuery", "Flutter", "Firebase"],
    "projects": ["chrisbinsunny.github.io", "portfolio"],
    "applications": [
      "calendar",
      "feedback",
      "notes",
      "photos",
      "messages",
      "maps",
      "safari",
      "terminal",
      "spotify",
      "vscode",
    ],
    "interests": ["Software Engineering", "Deep Learning", "Computer Vision"],
    "languages": ["Javascript", "C++", "Java", "Dart", "Python"],
  };
  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  Widget createCard() {
    var commandController = TextEditingController();
    commandTECs.add(commandController);
    return TerminalCommand(
      commandController: commandController,
      onSubmit: () {
        setState(() {
          processCommands(commandController.text);
          commandCards.add(createCard());
          oldCommands.add(commandController.text);
        });
      },
    );
  }

  processCommands(String text) {
    text = text.toLowerCase();
    var textWords = text.split(" ");
    String command = textWords[0];
    textWords.removeAt(0);
    String variable = "";
    output = "";
    if (textWords.length > 0) variable = textWords[0];
    switch (command) {
      case "":
        break;
      case "ls":
        String target;
        if (variable == "" || variable == null)
          target = currentDir;
        else {
          target = textWords[0];
        }
        if (textWords.length > 1) {
          output = "Too many arguments found, 1 argument expected.";
          break;
        }
        if (contents.containsKey(target)) {
          if (contents[target].length < 10) {
            int maxLen = 0;
            for (int i = 0; i < contents[target].length; i++) {
              if (contents[target][i].length > maxLen)
                maxLen = contents[target][i].length;
            }
            maxLen += 5;
            for (int i = 0; i < contents[target].length; i++) {
              output += "${contents[target][i].capitalize()}";
              if ((i + 1) % 3 == 0)
                output += "\n";
              else
                output += " " * (maxLen - contents[target][i].length);
            }
          } else
            contents[target].forEach((item) {
              output += "${item.capitalize()}\n";
            });
          break;
        } else {
          output = "ls: $target: No such file or directory";
        }
        break;
      case "open":
        if (variable=="-a"||currentDir=="applications")
          {
            switch (textWords[1]){
              case "finder":
                output="Opening Finder";
                Provider.of<OnOff>(context, listen: false).openFinder();
                break;
              case "safari":
                output="Opening Safari";
                Provider.of<OnOff>(context, listen: false).openSafari();
                break;
              case "messages":
                output="Opening Messages";
             //TODO   Provider.of<OnOff>(context, listen: false).openMessages();
                break;
              case "maps":
                output="Opening Maps";
             //TODO   Provider.of<OnOff>(context, listen: false).openMaps();
                break;
              case "spotify":
                output="Opening Spotify";
                Provider.of<OnOff>(context, listen: false).openSpotify();
                break;
              case "terminal":
                output="Opening Terminal";
                Provider.of<OnOff>(context, listen: false).openTerminal();
                break;
              case "vscode":
                output="Opening Visual Studio Code";
                Provider.of<OnOff>(context, listen: false).openVS();
                break;
              case "photos":
                output="Opening Photos";
            //TODO    Provider.of<OnOff>(context, listen: false).openPhotos();
                break;
              case "calendar":
                output="Opening Calendar";
                Provider.of<OnOff>(context, listen: false).openCalendar();
                break;
              case "notes":
                output="Opening Notes";
             //TODO   Provider.of<OnOff>(context, listen: false).openNotes();
                break;
              case "feedback":
                output="Opening Feedback";
                Provider.of<OnOff>(context, listen: false).openFeedBack();
                break;
              default:
                output="Application not found or Installed.";
            }
          }
        else{
          output="Can't open the application from this location. Try using \"open -a\".";
        }
        break;
      case "cd":
        if (variable == "") {
          currentDir = "~"; //TODO currently moves to root. should adjust as macos
          break;
        }
        if (textWords.length > 1) {
          output = "Too many arguments found, 1 argument expected.";
          break;
        }
        if (variable == ".." || variable == "../") {
          if (currentDir == "~") {
            output = "Can't go back. Reached the end";
            break;
          }

          var folders = directory.split("/");
          currentDir = folders[folders.length - 2];

          folders.removeAt(folders.length - 1);
          directory = folders.join("/");
          break;
        }
        if (variable == "personal-documents") {
          output = "/$currentDir : Permission denied.";
          break;
        }
        if (contents[currentDir].contains(variable)) {
          directory = directory + "/" + variable;
          currentDir = variable;
        } else {
          output = "cd: $variable: No such file or directory";
        }
        break;
      case "echo":
        output = textWords.join(" ");
        break;
      case "clear":
        //TODO
        break;
      case "exit":
        {
          directory="/~";
          Provider.of<OnOff>(context, listen: false).toggleTerminal();
        }
        break;
      case "sudo":
        output =
            "\"With great power comes great responsibility.\" ~Peter Parker Principle";
        break;
      default:
        output = "Command '" +
            command +
            "' not found!\nTry something like: [ cd, ls, echo, clear, exit, mkdir]";
    }
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          if (updownIndex < oldCommands.length) {
            updownIndex++;
          }
          debugPrint("Up.${oldCommands[oldCommands.length - updownIndex]}");
          commandTECs.last.text = oldCommands[oldCommands.length - updownIndex];
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          if (updownIndex > 1) {
            updownIndex--;
          }
          debugPrint("Down.${oldCommands[oldCommands.length - updownIndex]}");
          commandTECs.last.text = oldCommands[oldCommands.length - updownIndex];
        });
      }
    }
  }

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    now = DateTime.now();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        commandCards.add(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 5,
              ),
              MBPText(
                text:
                    "Last login: ${DateFormat("E LLL d HH:mm:ss").format(now)} on console",
                color: Theme.of(context).cardColor.withOpacity(1),
                fontFamily: "Menlo",
                size: 10,
              ),
            ],
          ),
        );
        commandCards.add(createCard());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    terminalFS = Provider.of<OnOff>(context).getTerminalFS;
    terminalPan = Provider.of<OnOff>(context).getTerminalPan;
    return AnimatedPositioned(
      duration: Duration(milliseconds: terminalPan ? 0 : 200),
      top: terminalFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
      left: terminalFS ? 0 : position.dx,
      child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: _handleKeyEvent,
          child: terminalWindow(context)),
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
                            directory="/~";
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
                padding: EdgeInsets.only(left: 6, right: 6, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: commandCards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return commandCards[index];
                  },
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
  final dir = directory.substring(directory.lastIndexOf("/") + 1).capitalize();
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
              text: "guest@Chrisbins-MacBook-Pro $dir %",
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
                        submit = true;
                      });
                      widget.onSubmit();
                    },
                    style: TextStyle(
                        color: Theme.of(context).cardColor.withOpacity(1),
                        fontFamily: "Menlo",
                        fontSize: 10,
                        fontWeight:
                            Theme.of(context).textTheme.headline4.fontWeight
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
          visible: submit && output.trim() != "",
          child: SelectableText(
            output,
            showCursor: false,
            style: TextStyle(
                color: Theme.of(context).cardColor.withOpacity(1),
                fontFamily: "Menlo",
                fontSize: 10,
                fontWeight: Theme.of(context).textTheme.headline4.fontWeight),
          ),
        ),
      ],
    );
  }
}
