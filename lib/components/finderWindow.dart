import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../apps/about.dart';
import '../apps/calendar.dart';
import '../apps/feedback/feedback.dart';
import '../apps/launchpad.dart';
import '../apps/messages/messages.dart';
import '../apps/safari/safariWindow.dart';
import '../apps/spotify.dart';
import '../apps/systemPreferences.dart';
import '../apps/terminal/terminal.dart';
import '../apps/vscode.dart';
import '../components/windowWidgets.dart';
import '../providers.dart';
import '../system/folders/folders.dart';
import '../system/folders/folders_CRUD.dart';
import '../system/openApps.dart';
import '../sizes.dart';
import 'dart:html' as html;

import '../widgets.dart';


class Finder extends StatefulWidget {
  final Offset? initPos;
  const Finder({this.initPos, Key? key}) : super(key: key);

  @override
  _FinderState createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  Offset? position = Offset(0.0, 0.0);
  String selected = "Applications";
  late bool finderFS;
  late bool finderPan;
  late DateTime now;
  late List<Folder> folders;
  final _navigatorKey2 = GlobalKey<NavigatorState>();


  getContent(){
    switch(selected){
      case "Applications":
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 6/3,
              mainAxisSpacing: screenHeight(context, mulBy: 0.05)
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight(context, mulBy: 0.04),
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            LaunchPadItem(
              iName: "About Me",
              onTap: () {
                tapFunctions(context);
                html.window.open('https://drive.google.com/uc?export=download&id=1cuIQHOhjvZfM_M74HjsICNpuzvMO0uKX', '_self');
                Provider.of<OnOff>(context, listen: false)
                    .maxAbout();
                Provider.of<Apps>(context, listen: false).openApp(
                    About(
                        key: ObjectKey("about"),
                        initPos: Offset(
                            screenWidth(context, mulBy: 0.2),
                            screenHeight(context, mulBy: 0.12))),
                    Provider.of<OnOff>(context, listen: false)
                        .maxAbout()
                );
              },
            ),
            LaunchPadItem(
              iName: "Safari",
              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<OnOff>(context, listen: false)
                      .maxSafari();
                  Provider.of<Apps>(context, listen: false).openApp(
                      Safari(
                          key: ObjectKey("safari"),
                          initPos: Offset(
                              screenWidth(context, mulBy: 0.14),
                              screenHeight(context, mulBy: 0.1))),
                      Provider.of<OnOff>(context, listen: false)
                          .maxSafari()
                  );
                });

              },
            ),
            LaunchPadItem(
              iName: "Messages",
              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
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
                });

              },
            ),
            LaunchPadItem(
              iName: "Maps",
              folder: true,

              onDoubleTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "maps",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Spotify",              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
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
                });
              },
            ),
            LaunchPadItem(
              iName: "Terminal",              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<OnOff>(context, listen: false)
                      .maxTerminal();
                  Provider.of<Apps>(context, listen: false).openApp(
                      Terminal(
                          key: ObjectKey("terminal"),
                          initPos: Offset(
                              screenWidth(context, mulBy: 0.28),
                              screenHeight(context, mulBy: 0.2))),
                      Provider.of<OnOff>(context, listen: false)
                          .maxTerminal()
                  );
                });


              },
            ),
            LaunchPadItem(
              iName: "Visual Studio Code",              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<OnOff>(context, listen: false).maxVS();
                  Provider.of<Apps>(context, listen: false).openApp(
                      VSCode(
                          key: ObjectKey("vscode"),
                          initPos: Offset(
                              screenWidth(context, mulBy: 0.24),
                              screenHeight(context, mulBy: 0.15))),
                      Provider.of<OnOff>(context, listen: false).maxVS()
                  );
                });


              },
            ),
            LaunchPadItem(
              iName: "Photos",              folder: true,

              onDoubleTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "photos",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Contacts",              folder: true,

              onDoubleTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "contacts",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            InkWell(
              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<OnOff>(context, listen: false)
                      .maxCalendar();
                  Provider.of<Apps>(context, listen: false).openApp(
                      Calendar(
                          key: ObjectKey("calendar"),
                          initPos: Offset(
                              screenWidth(context, mulBy: 0.24),
                              screenHeight(context, mulBy: 0.15)
                          )
                      ),
                      Provider.of<OnOff>(context, listen: false)
                          .maxCalendar()
                  );
                });


              },
              child: Column(
                children: [
                  Expanded(
                    ///For setting the Text on the icon on position. Done by getting relative position.
                    child: LayoutBuilder(builder: (context, cont) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset(
                            "assets/apps/calendar.png",
                          ),
                          Positioned(
                            top: cont.smallest.height * .13,
                            child: Container(
                              height:
                              cont.maxHeight*0.23,
                              width:
                              screenWidth(context, mulBy: 0.03),
                              //color: Colors.green,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "${DateFormat('LLL').format(now).toUpperCase()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "SF",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: cont.smallest.height * .35,
                            child: Container(
                              height:
                              cont.maxHeight*0.5,
                              width:
                              screenWidth(context, mulBy: 0.03),
                              //color:Colors.green,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "${DateFormat('d').format(now).toUpperCase()}",
                                  style: TextStyle(
                                      color: Colors.black87
                                          .withOpacity(0.8),
                                      fontFamily: 'SF',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },),
                  ),
                  MBPText(
                      text: "Calendar",
                      color: Theme.of(context).cardColor.withOpacity(1),
                  )
                ],
              ),
            ),
            LaunchPadItem(
              iName: "Notes",              folder: true,

              onDoubleTap: (){
                Provider.of<DataBus>(context, listen: false).setNotification(
                    "App has not been installed. Create the app on GitHub.",
                    "https://github.com/chrisbinsunny",
                    "notes",
                    "Not installed"
                );
                Provider.of<OnOff>(context, listen: false).onNotifications();
              },
            ),
            LaunchPadItem(
              iName: "Feedback",              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
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
                });

              },
            ),
            LaunchPadItem(
              iName: "System Preferences",              folder: true,

              onDoubleTap: () {
                tapFunctions(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<OnOff>(context, listen: false)
                      .maxSysPref();
                  Provider.of<Apps>(context, listen: false).openApp(
                      SystemPreferences(
                          key: ObjectKey("systemPreferences"),
                          initPos: Offset(
                              screenWidth(context, mulBy: 0.27),
                              screenHeight(context, mulBy: 0.13))),
                      Provider.of<OnOff>(context, listen: false)
                          .maxSysPref()
                  );
                });

              },
            ),
          ],
        );
        break;
      case "Desktop":
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 6/5,
              mainAxisSpacing: screenHeight(context, mulBy: 0.05)
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight(context, mulBy: 0.04),
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: folders.map((e) =>
              FolderForFinder(
                name: e.name,
                renaming: false,

              )
          ).toList(),
        );
        break;
      case "Documents":
        return WillPopScope(
          onWillPop: () async => !await _navigatorKey2.currentState!.maybePop(),
          child: Navigator(
            key: _navigatorKey2,
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context)
                {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 6/5.5,
                        mainAxisSpacing: screenHeight(context, mulBy: 0.05)
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context, mulBy: 0.04),
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    children: [
                      FinderItems(
                        name: "Cabby: Published Paper.pdf",
                        link: "https://www.transistonline.com/downloads/cabby-the-ride-sharing-platform/",
                      ),

                      FinderItems(
                        name: "Chrisbin Resume.pdf",
                        link: "https://drive.google.com/file/d/1cuIQHOhjvZfM_M74HjsICNpuzvMO0uKX/view",
                      ),
                      FinderItems(
                        name: "Chrisbin Resume Dark long.pdf",
                        link: "https://drive.google.com/file/d/1lPK15gLkNr2Rso3JNr0b-RdmFN245w87/view",
                      ),
                      FinderItems(
                        name: "Chrisbin Resume Light long.pdf",
                        link: "https://drive.google.com/file/d/11j0UCdSXBRA1DPFct1EImmKFpyQu0fiH/view",
                      ),

                      FinderItems(
                        name: "Interests",
                        link: "",
                        nav: (){
                          Navigator.of(context)
                              .push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                Interests(),
                          ));
                        },
                        folder: true,
                      ),
                      FinderItems(
                        name: "Languages",
                        link: "",
                        nav: (){
                          Navigator.of(context)
                              .push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                Languages(),
                          ));
                        },
                        folder: true,
                      ),
                      FinderItems(
                        name: "Projects",
                        link: "",
                        nav: (){
                          Navigator.of(context)
                              .push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                Projects(),
                          ));
                        },
                        folder: true,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
        break;
      case "Downloads":
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 6/5.5,
              mainAxisSpacing: screenHeight(context, mulBy: 0.05)
          ),
          padding: EdgeInsets.symmetric(
            vertical: screenHeight(context, mulBy: 0.04),
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            FinderItems(
              name: "Antonn- Game Testing platform.pdf",
              link: "",
            ),
            FinderItems(
              name: "Cabby final.pdf",
              link: "",
            ),
            FinderItems(
              name: "Chrisbin seminar.pdf",
              link: "",
            ),
            FinderItems(
              name: "Flutter Talks.pdf",
              link: "",
            ),
            FinderItems(
              name: "Ride Sharing platform.pdf",
              link: "",
            ),
            FinderItems(
              name: "Dream.zip",
              link: "",
              nav: null,
              folder: true,
            ),
          ],
        );
        break;
      case "Movies":
        return SizedBox();
        break;
      case "Music":
        return SizedBox();
        break;
      case "Pictures":
        return SizedBox();
        break;
    }
  }


  @override
  void initState() {
    position = widget.initPos;
    now = DateTime.now();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var finderOpen = Provider.of<OnOff>(context).getFinder;
    finderFS = Provider.of<OnOff>(context).getFinderFS;
    finderPan = Provider.of<OnOff>(context).getFinderPan;
    folders = Provider.of<Folders>(context, listen: true).getFolders;
      return AnimatedPositioned(
            duration: Duration(milliseconds: finderPan ? 0 : 200),
            top: finderFS ? 25 : position!.dy,
            left: finderFS ? 0 : position!.dx,
            child: finderWindow(context),
          );
  }

  AnimatedContainer finderWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: finderFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: finderFS
          ? screenHeight(context, mulBy: 0.975)
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
                        horizontal: screenWidth(context, mulBy: 0.013),
                        vertical: screenHeight(context, mulBy: 0.025)),
                    height: screenHeight(context),
                    width: screenWidth(context, mulBy: 0.14),
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.035),
                        ),
                        Text(
                          "Favourites",
                          style: TextStyle(
                            fontWeight: Theme.of(context)
                                .textTheme
                                .headline1!
                                .fontWeight,
                            fontFamily: "SF",
                            color: Theme.of(context).cardColor.withOpacity(.38),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.015),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                selected = "Applications";
                              });
                            },
                            child: LeftPaneItems(
                              iName: "Applications",
                              isSelected:
                                  (selected == "Applications") ? true : false,
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Desktop";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Desktop",
                            isSelected: (selected == "Desktop") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Documents";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Documents",
                            isSelected:
                                (selected == "Documents") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Downloads";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Downloads",
                            isSelected:
                                (selected == "Downloads") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Movies";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Movies",
                            isSelected: (selected == "Movies") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Music";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Music",
                            isSelected: (selected == "Music") ? true : false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Pictures";
                            });
                          },
                          child: LeftPaneItems(
                            iName: "Pictures",
                            isSelected: (selected == "Pictures") ? true : false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: screenWidth(context, mulBy: 0.013),
                      right: screenWidth(context, mulBy: 0.013),
                      top: screenHeight(context, mulBy: 0.03)),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async => !await _navigatorKey2.currentState!.maybePop(),
                            child: Row(
                              children: [
                                Image.asset("assets/icons/backB.png",
                                    height: 18),
                                SizedBox(
                                  width: screenWidth(context, mulBy: 0.01),
                                ),
                                Image.asset("assets/icons/forwB.png",
                                    height: 18.5),
                                SizedBox(
                                  width: screenWidth(context, mulBy: 0.007),
                                ),
                                Container(
                                  width: screenWidth(context, mulBy: 0.07),
                                  child: MBPText(
                                    text: selected,
                                    size: 15,
                                    weight: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .fontWeight,
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(1),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.w700,
                                    //   color: Colors.black.withOpacity(0.7),
                                    //   fontSize: 15,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset("assets/icons/sortB.png", height: 20),
                          Row(
                            children: [
                              Image.asset("assets/icons/iconB.png",
                                  height: 18),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.015),
                              ),
                              Image.asset("assets/icons/shareB.png",
                                  height: 19),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.015),
                              ),
                              Image.asset("assets/icons/tagB.png",
                                  height: 15),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("assets/icons/moreB.png",
                                  height: 15),
                              SizedBox(
                                width: screenWidth(context, mulBy: 0.007),
                              ),
                              Image.asset("assets/icons/searchB.png",
                                  height: 15),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.01),
                      ),

                      Expanded(child: getContent(),)
                    ],
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!finderFS) {
                setState(() {
                  position = Offset(position!.dx + tapInfo.delta.dx,
                      position!.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onFinderPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offFinderPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleFinderFS();
            },
            child: Container(
                alignment: Alignment.centerRight,
                width: finderFS
                    ? screenWidth(context, mulBy: 0.95)
                    : screenWidth(context, mulBy: 0.5),
                height: screenHeight(context, mulBy: 0.04),
                color: Colors.transparent),
          ),
          Visibility(
            visible: topApp != "Finder",
            child: InkWell(
              onTap: (){
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("finder"));
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


class FolderForFinder extends StatefulWidget {
  String? name;
  bool? renaming;
  bool selected;
  late VoidCallback deSelectFolder;
  late VoidCallback renameFolder;
  FolderForFinder({Key? key, this.name,  this.renaming= false, this.selected=false,}): super(key: key);
  @override
  _FolderForFinderState createState() => _FolderForFinderState();
}

class _FolderForFinderState extends State<FolderForFinder> {
  TextEditingController? controller;
  FocusNode _focusNode = FocusNode();
  bool pan= false;
  bool bgVisible= false;

  @override
  void initState() {
    super.initState();
    controller = new TextEditingController(text: widget.name, );
    controller!.selection=TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
    selectText();
    widget.renameFolder=(){
      if (!mounted) return;
      setState(() {
        widget.renaming=true;
      });
    };
    widget.deSelectFolder= (){
      if (!mounted) return;
      setState(() {
        widget.selected=false;
        widget.renaming=false;
        //widget.name=controller.text.toString();
      });
    };
  }

  void selectText(){
    _focusNode.addListener(() {
      if(_focusNode.hasFocus) {
        controller!.selection = TextSelection(baseOffset: 0, extentOffset: controller!.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Folder> folders= Provider.of<Folders>(context).getFolders;
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: GestureDetector(
        //TODO
        ///Gestures are turned off for now. Will have to re-do the gestures for folderforFinder
        // onTap: (){
        //   tapFunctions(context);
        //   if (!mounted) return;
        //   setState(() {
        //     widget.selected=true;
        //   });
        // },
        //
        // onSecondaryTap: (){
        //   if (!mounted) return;
        //   setState(() {
        //     widget.selected=true;
        //   });
        //   Provider.of<OnOff>(context, listen: false).onFRCM();
        // },
        // onSecondaryTapDown: (details){
        //   tapFunctions(context);
        //   Provider.of<DataBus>(context, listen: false).setPos(details.globalPosition);
        // },
        child: Container(
          width: screenWidth(context, mulBy: 0.08),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: screenHeight(context, mulBy: 0.1),
                padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.0005)),
                decoration: (widget.renaming!||widget.selected)?BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.4),
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(4)
                ):BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.0),
                      width: 2
                  ),
                ),
                child: Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.085), width: screenWidth(context, mulBy: 0.045), ),
              ),
              SizedBox(height: screenHeight(context, mulBy: 0.005), ),
              widget.renaming!?
              Container(
                height: screenHeight(context, mulBy: 0.024),
                width: screenWidth(context, mulBy: 0.06),
                decoration: BoxDecoration(
                    color: Color(0xff1a6cc4).withOpacity(0.7),
                    border: Border.all(
                        color: Colors.blueAccent
                    ),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Theme(
                  data: ThemeData(textSelectionTheme: TextSelectionThemeData(
                      selectionColor: Colors.transparent)),
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(top: 4.5, bottom: 0, left: 0, right: 0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    cursorColor: Colors.white60,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "HN",
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                    ),
                    onSubmitted: (s){
                      if (!mounted) return;
                      setState(() {
                        widget.renaming=false;
                        if(controller!.text=="")    ///changes controller to sys found name if empty.
                          controller!.text=widget.name!;
                        int folderNum=0;
                        for(int element=0; element<folders.length; element++) {
                          if(folders[element].name==controller!.text) {
                            if(int.tryParse(folders[element].name!.split(" ").last)!=null) { ///for not changing "untitled folder" to "untitled 1"
                              folderNum = int.parse(folders[element].name!.split(" ").last) ?? folderNum;
                              controller!.text = "${controller!.text.substring(0, controller!.text.lastIndexOf(" "))} ${++folderNum}";
                              element=0;   ///for checking if changed name == name in already checked folders
                            }
                            else{
                              controller!.text = "${controller!.text} ${++folderNum}";
                            }
                          }
                        }
                        FoldersDataCRUD.renameFolder(widget.name!, controller!.text.toString());
                        widget.name=controller!.text.toString();
                      });
                    },
                  ),
                ),
              )
                  :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeight(context, mulBy: 0.024),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.005)),
                    alignment: Alignment.center,
                    decoration: widget.selected?BoxDecoration(
                        color: Color(0xff0058d0),
                        borderRadius: BorderRadius.circular(3)
                    ):BoxDecoration(),
                    child: Text(widget.name??"", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).cardColor.withOpacity(1), fontFamily: "HN", fontWeight: FontWeight.w500, fontSize: 12,), maxLines: 1, overflow: TextOverflow.ellipsis, ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FinderItems extends StatelessWidget {
  const FinderItems({Key? key, required this.name, required this.link, this.folder=false, this.nav}) : super(key: key);

  final String name, link;
  final VoidCallback? nav;
  final bool folder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: folder?nav:(link=="")?null:(){html.window.open(link, 'new tab');},
      child: Container(
        width: screenWidth(context, mulBy: 0.08),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: screenHeight(context, mulBy: 0.1),
                padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.0005)),
                decoration: BoxDecoration(),
                child: Image.asset(folder?"assets/icons/folder.png":"assets/icons/pdfMac.png", height: screenHeight(context, mulBy: 0.085), width: screenWidth(context, mulBy: 0.045), ),
              ),
            ),
            SizedBox(height: screenHeight(context, mulBy: 0.005), ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.005)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(),
      width: screenWidth(context, mulBy: 0.07),
                  child: Text(name+"\n", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).cardColor.withOpacity(1), fontFamily: "HN", fontWeight: FontWeight.w500, fontSize: 12,), maxLines: 2, overflow: TextOverflow.ellipsis, ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Interests extends StatelessWidget {
  const Interests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 6/5.5,
            mainAxisSpacing: screenHeight(context, mulBy: 0.05)
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight(context, mulBy: 0.04),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          FinderItems(
            name: "Software Engineering",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Game Development",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "AI in Games",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Deep Learning",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Computer Vision",
            link: "",
            folder: true,
          ),
        ],
      ),
    );
  }
}

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 6/5.5,
            mainAxisSpacing: screenHeight(context, mulBy: 0.05)
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight(context, mulBy: 0.04),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          FinderItems(
            name: "Flutter",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Dart",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Python",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "GoLang",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "C++",
            link: "",
            folder: true,
          ),
          FinderItems(
            name: "Java",
            link: "",
            folder: true,
          ),
        ],
      ),
    );
  }
}

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 6/5.5,
            mainAxisSpacing: screenHeight(context, mulBy: 0.05)
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight(context, mulBy: 0.04),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          FinderItems(
            name: "Macbook",
            link: "",
            nav: (){html.window.open("https://chrisbinsunny.github.io/chrishub", 'new tab');},
            folder: true,
          ),
          FinderItems(
            name: "Dream",
            link: "",
            nav: (){html.window.open("https://chrisbinsunny.github.io/dream", 'new tab');},
            folder: true,
          ),
          FinderItems(
            name: "Portfolio old",
            link: "",
            nav: (){html.window.open("https://chrisbinsunny.github.io", 'new tab');},
            folder: true,
          ),
          FinderItems(
            name: "Flutter-Talks",
            link: "",
            nav: (){html.window.open("https://chrisbinsunny.github.io/Flutter-Talks", 'new tab');},
            folder: true,
          ),
        ],
      ),
    );
  }
}