import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import '../../components/finderWindow.dart';
import '../../providers.dart';
import '../../system/folders/folders.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import 'dart:html' as html;

import '../calendar.dart';
import '../feedback/feedback.dart';
import '../messages/messages.dart';
import '../safari/safariWindow.dart';
import '../spotify.dart';
import '../vscode.dart';
import 'commands.dart';

//TODO Has an issue with cursor. Currently the issue is present in master branch of flutter.
/// GitHub Issue: https://github.com/flutter/flutter/issues/31661

//TODO Clear command not working

String output = "";
String directory = "/~";

class Terminal extends StatefulWidget {
  final Offset? initPos;
  const Terminal({this.initPos, Key? key}) : super(key: key);

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  Offset? position = Offset(0.0, 0.0);
  late bool terminalFS;
  late bool terminalPan;
  var commandTECs = <TextEditingController>[];
  var oldCommands = <String>[""];
  var commandCards = <Widget>[];
  late DateTime now;
  int updownIndex = 0;
  String currentDir = "~";

  ///Data should be entered as lowercase. It is converted to alternate caps when it is displayed.
  ///
  /// Links are added to end of pdf name after ////
  Map<String, List<String>> contents = {
    "~": [
      "applications",
      "documents",
      "downloads",
      "library",
      "movies",
      "music",
      "pictures",
    ],
    "library": [
      "Alchemist",
      "One Night at a call centre",
      "Revolution 2020"
    ],
    "skills": ["Front-end development", "jQuery", "Flutter", "Firebase"],
    "projects": ["Macbook", "Dream", "chrisbinsunny.github.io",  "Flutter-Talks", ],
    "applications": [
      "calendar",
      "feedback",
      "notes",
      "photos",
      "messages",
      "maps",
      "safari",
      "spotify",
      "vscode",
    ],
    "interests": ["Software Engineering","Game Development", "AI in Games","Deep Learning", "Computer Vision"],
    "languages": ["Flutter", "Dart", "Python", "GoLang", "C++", "Java",  ],
    "documents":[
      "cabby: published paper.pdf////https://www.transistonline.com/downloads/cabby-the-ride-sharing-platform/",
      "chrisbin resume dark.pdf////https://drive.google.com/file/d/1lPK15gLkNr2Rso3JNr0b-RdmFN245w87/view",
      "chrisbin resume light.pdf////https://drive.google.com/file/d/11j0UCdSXBRA1DPFct1EImmKFpyQu0fiH/view",
      "interests",
      "languages",
      "projects",
    ],
    "downloads":[
      "Antonn- Game Testing platform.pdf",
      "Cabby final.pdf",
      "Chrisbin seminar.docx",
      "Chrisbin seminar.pdf",
      "Dream.zip",
      "Flutter_F_4K_Wallpaper.png",
      "Flutter Talks.pdf"
      "Ride Sharing platform.pdf",
    ],
    "movies":[],
    "music":[],
    "pictures":[],
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
    String textOrg= text;
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
        if (variable == "")
          target = currentDir;

        else {
          target = textWords[0];
        }
        if (textWords.length > 1) {
          output = "Too many arguments found, 1 argument expected.";
          break;
        }
        if (contents.containsKey(target)) {
          if (contents[target]!.length < 10) {
            int maxLen = 0;
            for (int i = 0; i < contents[target]!.length; i++) {
              if (contents[target]![i].length > maxLen)
                maxLen = contents[target]![i].length;
            }
            maxLen += 5;
            for (int i = 0; i < contents[target]!.length; i++) {
              output += "${contents[target]![i].split("////")[0].capitalize()}";
              if ((i + 1) % 3 == 0)
                output += "\n";
              else
                output += " " * (maxLen - contents[target]![i].length);
            }
          } else
            contents[target]!.forEach((item) {
              output += "${item.split("////")[0].capitalize()}\n";
            });
          break;
        } else {
          output = "ls: $target: No such file or directory";
        }
        break;


      case "open":
        if (variable=="-a"||currentDir=="applications")
          {
            switch (textWords[currentDir=="applications"?0:1]){
              case "finder":
                output="Opening Finder";
                tapFunctions(context);
                Provider.of<OnOff>(context, listen: false)
                    .maxFinder();
                Provider.of<Apps>(context, listen: false).openApp(
                    Finder(
                        key: ObjectKey("finder"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.2),
                            screenHeight(context, mulBy: 0.18))),
                    Provider.of<OnOff>(context, listen: false)
                        .maxFinder()
                );
                break;
              case "safari":
                output="Opening Safari";
                tapFunctions(context);
                Provider.of<OnOff>(context, listen: false)
                    .maxSafari();
                Provider.of<Apps>(context, listen: false).openApp(
                    Safari(
                        key: ObjectKey("safari"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.21),
                            screenHeight(context, mulBy: 0.14))),
                    Provider.of<OnOff>(context, listen: false)
                        .maxSafari()
                );
                break;
              case "messages":
                output="Opening Messages";
                tapFunctions(context);

                Provider.of<OnOff>(context, listen: false)
                    .maxMessages();
                Provider.of<Apps>(context, listen: false).openApp(
                    Messages(
                        key: ObjectKey("messages"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.27),
                            screenHeight(context, mulBy: 0.2))),
                    Provider.of<OnOff>(context, listen: false)
                        .maxMessages()
                );
                break;
              case "maps":
                output="Opening Maps";
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "maps",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
                break;
              case "spotify":
                output="Opening Spotify";
                tapFunctions(context);

                Provider.of<OnOff>(context, listen: false)
                    .maxSpotify();
                Provider.of<Apps>(context, listen: false).openApp(
                    Spotify(
                        key: ObjectKey("spotify"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.24),
                            screenHeight(context, mulBy: 0.15)
                        )),
                    Provider.of<OnOff>(context, listen: false)
                        .maxSpotify()
                );
                break;
              case "terminal":
                output="Opening Terminal";
                break;
              case "vscode":
                output="Opening Visual Studio Code";
                tapFunctions(context);

                Provider.of<OnOff>(context, listen: false).maxVS();
                Provider.of<Apps>(context, listen: false).openApp(
                    VSCode(
                        key: ObjectKey("vscode"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.24),
                            screenHeight(context, mulBy: 0.15))),
                    Provider.of<OnOff>(context, listen: false).maxVS()
                );
                break;
              case "photos":
                output="Opening Photos";
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "photos",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
                break;
              case "calendar":
                output="Opening Calendar";
                tapFunctions(context);
                Provider.of<OnOff>(context, listen: false)
                    .maxCalendar();
                Provider.of<Apps>(context, listen: false).openApp(
                    Calendar(
                        key: ObjectKey("calendar"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.24),
                            screenHeight(context, mulBy: 0.15))
                    ),
                    Provider.of<OnOff>(context, listen: false)
                        .maxCalendar()
                );
                break;
              case "notes":
                output="Opening Notes";
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "notes",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
                break;
              case "feedback":
                output="Opening Feedback";
                tapFunctions(context);

                Provider.of<OnOff>(context, listen: false)
                    .maxFeedBack();
                Provider.of<Apps>(context, listen: false).openApp(
                    FeedBack(
                        key: ObjectKey("feedback"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.2),
                            screenHeight(context, mulBy: 0.12))),
                    Provider.of<OnOff>(context, listen: false)
                        .maxFeedBack()
                );
                break;
              default:
                output="Application not found or Installed.";
            }
          }
        else if(currentDir=="projects"){
          String link="404";
          switch(variable){
            case "macbook":
              link= "https://chrisbinsunny.github.io/chrishub";
              break;
            case "dream":
              link= "https://chrisbinsunny.github.io/dream";
              break;
            case "chrisbinsunny.github.io":
              link= "https://chrisbinsunny.github.io";
              break;
            case "flutter-talks":
              link= "https://chrisbinsunny.github.io/Flutter-Talks";
              break;
          }
          if(link=="404"){
            output="Can't open the application from this location. Try using \"open -a\".";
          }
          else{
            output="Opening ${variable}";
            Future.delayed(const Duration(seconds: 1), () {
              html.window.open(link, 'new tab');
            });
          }
        }
        else if(textWords.join(" ").contains(".pdf")){
          String pdf="";
          contents[currentDir]!.forEach((element) {
            if(element.split("////")[0]==textWords.join(" ")){
              pdf= element;
            }
          });
          if(pdf==""){
            output="File \"${textWords.join(" ")}\" not found. Check the file name";
          }
          else{
            output="Opening ${pdf.split("////")[0].capitalize()}";
            Future.delayed(const Duration(seconds: 1), () {
              html.window.open(pdf.split("////")[1], 'new tab');
            });
          }
        }
        else{
          output="Can't open the application from this location. Try using \"open -a\".";
        }
        break;


      case "cd":
        if (variable == "") {
          log("1");
          currentDir = "~";
          directory = "/~";
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
        if (currentDir == "downloads") {
          output = "/$currentDir : Permission denied.";
          break;
        }
        if (contents[currentDir]!.contains(variable,)) {
          directory = directory + "/" + variable;
          currentDir = variable;
        } else {
          output = "cd: $variable: No such file or directory";
        }
        break;


      case "mkdir":
        if(variable=="") {
          output = "usage: mkdir directory ...";
          break;
        }
        if (textWords.length > 1) {
          for(String name in textOrg.split(" ")..removeAt(0))  ///Org text used for for Upper and Lower org cases
            Provider.of<Folders>(context, listen: false).createFolder(context, renaming: false, name: name);
          break;
        }
        Provider.of<Folders>(context, listen: false).createFolder(context, renaming: false, name: textOrg.split(" ")[1]);
        break;

      case "echo":
        output = textWords.join(" ");
        break;


      case "clear":
        ///Not working as of now.
      ///What went wrong: The textfield is not enabled after clearing. leaving the code below.

        // commandCards.clear();
        // commandCards.add(
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       SizedBox(
        //         height: 5,
        //       ),
        //       MBPText(
        //         text:
        //         "Last login: ${DateFormat("E LLL d HH:mm:ss").format(now)} on console",
        //         color: Theme.of(context).cardColor.withOpacity(1),
        //         fontFamily: "Menlo",
        //         size: 10,
        //       ),
        //     ],
        //   ),
        // );

      output="Bug found!!! Submit an issue on GitHub.";
        break;
      case "exit":
        {
          directory="/~";
          Provider.of<Apps>(context, listen: false).closeApp("terminal");
          Provider.of<OnOff>(context, listen: false)
              .offTerminalFS();
          Provider.of<OnOff>(context, listen: false).toggleTerminal();
        }
        break;
      case "sudo":
        output =
            "\"With great power comes great responsibility.\" ~Peter Parker";
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
          commandTECs.last.text = oldCommands[oldCommands.length - updownIndex];
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          if (updownIndex > 1) {
            updownIndex--;
          }
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
      top: terminalFS ? 25 : position!.dy,
      left: terminalFS ? 0 : position!.dx,
      child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: _handleKeyEvent,
          child: terminalWindow(context)),
    );
  }

  AnimatedContainer terminalWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: terminalFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.4),
      height: terminalFS
          ? screenHeight(context, mulBy: 0.975)
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
      child: Stack(
        children: [
          Column(
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
                          weight: Theme.of(context).textTheme.headline4!.fontWeight,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onPanUpdate: (tapInfo) {
                      if (!terminalFS) {
                        setState(() {
                          position = Offset(position!.dx + tapInfo.delta.dx,
                              position!.dy + tapInfo.delta.dy);
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
                                Provider.of<Apps>(context, listen: false).closeApp("terminal");
                                Provider.of<OnOff>(context, listen: false)
                                    .offTerminalFS();
                                Provider.of<OnOff>(context, listen: false).toggleTerminal();
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: (){
                                Provider.of<OnOff>(context, listen: false).toggleTerminal();
                                Provider.of<OnOff>(context, listen: false).offTerminalFS();
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


    Visibility(
      visible: topApp != "Terminal",
      child: InkWell(
        onTap: (){
          Provider.of<Apps>(context, listen: false)
              .bringToTop(ObjectKey("terminal"));
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

class TerminalCommand extends StatefulWidget {
  final TextEditingController? commandController;
  final VoidCallback? onSubmit;
  TerminalCommand({Key? key, this.commandController, this.onSubmit})
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
                      widget.onSubmit!();
                    },
                    style: TextStyle(
                        color: Theme.of(context).cardColor.withOpacity(1),
                        fontFamily: "Menlo",
                        fontSize: 10,
                        fontWeight:
                            Theme.of(context).textTheme.headline4!.fontWeight
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
                fontWeight: Theme.of(context).textTheme.headline4!.fontWeight),
          ),
        ),
      ],
    );
  }
}
