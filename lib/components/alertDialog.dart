import 'dart:developer';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
import 'dart:ui' as ui;

import '../widgets.dart';

class MacOSAlertDialog extends StatelessWidget {
  MacOSAlertDialog({Key? key,   }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    log(screenWidth(context,
        mulBy: 0.17).toString());
    ///Checking if the system is running on mobile and if not request fullscreen
    final bool isWebMobile = true;



    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: 70.0, sigmaY: 70.0),
          child: Container(
            width: screenWidth(context,
                mulBy: 0.165),
            height: screenHeight(context,
                mulBy: 0.37),
            constraints: const BoxConstraints(
              minWidth: 250,
              minHeight: 340,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                borderRadius:
                BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 10,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                const EdgeInsets
                    .symmetric(
                    horizontal: 30,
                  vertical: 5
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Icon(
                      CupertinoIcons.exclamationmark_circle,
                          color: Colors.redAccent,
                          size: 65,
                          //device_desktop
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Chrisbin's MacBook Pro",
                      style: TextStyle(
                        color: Theme.of(context).cardColor.withOpacity(1),
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20
                      ),
                      child: isWebMobile?
                      Text(
                        "The website is recommended to be used on a computer browser. "
                            "Please use a computer browser for full experience.",
                        style: TextStyle(
                            color: Theme.of(context).cardColor.withOpacity(1),
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),
                        textAlign: TextAlign.center,
                      ):
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "The website is recommended to be used in fullscreen. "
                                  "Click the button below or the icon(",
                            ),
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.fullscreen,
                                size: 14,
                                color: Theme.of(context).cardColor.withOpacity(1),
                              ),
                            ),
                            TextSpan(
                              text: ") on the desktop to toggle fullscreen.",
                            ),
                          ],
                          style: TextStyle(
                              color: Theme.of(context).cardColor.withOpacity(1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                          ),
                        ),
                        textAlign: TextAlign.center,

                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isWebMobile?
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 7
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          ),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff107deb),
                                  Color(0xff226eca),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ),
                            borderRadius: BorderRadius.circular(7)
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ):
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 7
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            "Full Screen",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff107deb),
                              Color(0xff226eca),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.circular(7)
                        ),
                      ),
                      onTap: (){
                        if(!isWebMobile){
                          document.documentElement!.requestFullscreen();
                        }
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: !isWebMobile,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 7
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(7)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}