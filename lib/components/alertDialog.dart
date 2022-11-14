import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
                mulBy: 0.185),
            height: screenHeight(context,
                mulBy: 0.46),
            constraints: const BoxConstraints(
              minWidth: 250,
              minHeight: 350,
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
                    horizontal: 7,
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
                    Text(
                      "Chrisbin's MacBook Pro is recommended to be used in fullscreen",
                      style: TextStyle(
                          color: Theme.of(context).cardColor.withOpacity(1),
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide.none)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 30
                            )),
                        enableFeedback: true,
                        backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
                        overlayColor: MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.3)),
                        elevation: MaterialStateProperty.all(0),
                        side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
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