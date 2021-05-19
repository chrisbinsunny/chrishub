import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componentsOnOff.dart';
import '../sizes.dart';

class ControlCentre extends StatefulWidget {
  const ControlCentre({Key key}) : super(key: key);

  @override
  _ControlCentreState createState() => _ControlCentreState();
}

class _ControlCentreState extends State<ControlCentre> {
  BoxShadow ccShadow = BoxShadow(
    color: Colors.black.withOpacity(.2),
    spreadRadius: 1,
    blurRadius: 2,
    offset: Offset(0, 1), // changes position of shadow
  );
  BoxDecoration ccDecoration = BoxDecoration(
      color: Colors.white.withOpacity(0.4),
      backgroundBlendMode: BlendMode.luminosity
  );
  @override
  Widget build(BuildContext context) {
    var ccOpen = Provider.of<OnOff>(context).getCc;
    return ccOpen
        ? Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.007),
                          vertical: screenHeight(context, mulBy: 0.010)),
                      height: screenHeight(context, mulBy: 0.45),
                      width: screenWidth(context, mulBy: 0.2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    ccShadow
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15.0, sigmaY: 15.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              mulBy: 0.013),
                                          vertical: screenHeight(context,
                                              mulBy: 0.025)),
                                      height:
                                          screenHeight(context, mulBy: 0.17),
                                      width: screenWidth(context, mulBy: 0.09),
                                      decoration: ccDecoration,
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: screenHeight(context, mulBy: 0.17),
                                width: screenWidth(context, mulBy: 0.09),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          ccShadow
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15.0, sigmaY: 15.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth(context,
                                                    mulBy: 0.013),
                                                vertical: screenHeight(context,
                                                    mulBy: 0.025)),
                                            height: screenHeight(context,
                                                mulBy: 0.08),
                                            width: screenWidth(context,
                                                mulBy: 0.09),
                                            decoration: ccDecoration,
                                            child: Row(
                                              children: [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          ccShadow
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15.0, sigmaY: 15.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth(context,
                                                    mulBy: 0.013),
                                                vertical: screenHeight(context,
                                                    mulBy: 0.025)),
                                            height: screenHeight(context,
                                                mulBy: 0.08),
                                            width: screenWidth(context,
                                                mulBy: 0.09),
                                            decoration: ccDecoration,
                                            child: Row(
                                              children: [
                                                Text("Dark Mode",style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                ccShadow
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                ccShadow
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                ccShadow
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 15.0, sigmaY: 15.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, mulBy: 0.013),
                                      vertical:
                                          screenHeight(context, mulBy: 0.025)),
                                  height: screenHeight(context, mulBy: 0.075),
                                  width: screenWidth(
                                    context,
                                  ),
                                  decoration: ccDecoration,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
