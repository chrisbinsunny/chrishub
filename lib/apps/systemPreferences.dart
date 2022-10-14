import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

//TODO: BUG Found>> After opening youtube all searches redirects to youtube.

class SystemPreferences extends StatefulWidget {
  final Offset? initPos;
  const SystemPreferences({this.initPos, Key? key}) : super(key: key);

  @override
  _SystemPreferencesState createState() => _SystemPreferencesState();
}

class _SystemPreferencesState extends State<SystemPreferences> {
  Offset? position = Offset(0.0, 0.0);
  String selected = "Applications";
  TextEditingController urlController = new TextEditingController();
  late bool sysPrefPan;
  String url = "";
  bool isDoc = false;

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sysPrefOpen = Provider.of<OnOff>(context).getSysPref;
    sysPrefPan = Provider.of<OnOff>(context).getSysPrefPan;
    return sysPrefOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: sysPrefPan ? 0 : 200),
            top:
                position!.dy,
            left:  position!.dx,
            child: sysPrefWindow(context),
          )
        : Container();
  }

  AnimatedContainer sysPrefWindow(BuildContext context) {
    String thm = Provider.of<ThemeNotifier>(context).findThm;
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: screenWidth(context, mulBy: 0.52),
      height: screenHeight(context, mulBy: 0.75),
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
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: screenHeight(context, mulBy: 0.06),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                  ),
                  GestureDetector(
                    onPanUpdate: (tapInfo) {
                      setState(() {
                        position = Offset(position!.dx + tapInfo.delta.dx,
                            position!.dy + tapInfo.delta.dy);
                      });
                    },
                    onPanStart: (details) {
                      Provider.of<OnOff>(context, listen: false).onSysPrefPan();
                    },
                    onPanEnd: (details) {
                      Provider.of<OnOff>(context, listen: false)
                          .offSysPrefPan();
                    },

                    child: Container(
                      alignment: Alignment.topRight,
                      width: screenWidth(context, mulBy: 0.7),
                      height: screenHeight(context, mulBy: 0.06),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 0.8))),
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
                                    .offSafariFS();
                                Provider.of<Apps>(context, listen: false)
                                    .closeApp("systemPreferences");
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleSysPref();
                                url = "";
                                urlController.text = "";
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleSysPref();
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
                            Container(
                              height: 11.5,
                              width: 11.5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        Center(
                          child: Container(
                            height: screenHeight(context, mulBy: 0.033),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              color:
                                  Theme.of(context).cardColor.withOpacity(0.5),
                              icon: Icon(
                                Icons.home_outlined,
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  url = "";
                                  urlController.text = "";
                                });
                              },
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        // Container(
                        //   width: 300,
                        //   height: screenHeight(context, mulBy: 0.03), //0.038
                        //   margin: EdgeInsets.zero,
                        //   decoration: BoxDecoration(
                        //     color: Color(0xff47454b),
                        //     borderRadius: BorderRadius.circular(5),
                        //   ),
                        //   child: Center(
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       child: TextField(
                        //         controller: urlController,
                        //         //textAlignVertical: TextAlignVertical.center,
                        //         textAlign: TextAlign.center,
                        //         cursorColor: Theme.of(context)
                        //             .cardColor
                        //             .withOpacity(0.55),
                        //         onSubmitted: (text) => handleURL(text),
                        //         style: TextStyle(
                        //           height: 2,
                        //           color: Theme.of(context)
                        //               .cardColor
                        //               .withOpacity(1),
                        //           fontFamily: "HN",
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 10,
                        //         ),
                        //         maxLines: 1,
                        //         decoration: InputDecoration(
                        //           hintText:
                        //               "Search or enter website name", //TODO
                        //           isCollapsed: true,
                        //           contentPadding:
                        //               EdgeInsets.fromLTRB(5.0, 00.0, 5.0, 3.0),
                        //           hintStyle: TextStyle(
                        //             height: 2,
                        //             color: Theme.of(context)
                        //                 .cardColor
                        //                 .withOpacity(0.4),
                        //             fontFamily: "HN",
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: 10,
                        //           ),
                        //           border: InputBorder.none,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Spacer(
                          flex: 6,
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
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                      ),

                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: topApp != "System Preferences",
            child: InkWell(
              onTap: () {
                Provider.of<Apps>(context, listen: false)
                    .bringToTop(ObjectKey("systemPreferences"));
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
