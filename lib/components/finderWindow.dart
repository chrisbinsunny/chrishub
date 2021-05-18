import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:provider/provider.dart';
import '../components/windowWidgets.dart';
import '../sizes.dart';

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  DragBox(this.initPos, this.label,);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);
  String selected = "Applications";
  //bool finderOpen= false;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    var finderOpen = Provider.of<OnOff>(context).getFinder;
    return finderOpen?Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          child: finderWindow(context),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          childWhenDragging: Container(
            width: 120.0,
            height: 120.0,
            color: Colors.grey.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          feedback: Container(
            width: screenWidth(context, mulBy: 0.55),
            height: screenHeight(context, mulBy: 0.65),
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
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Material(
                child: Row(
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
                              color: Colors.white.withOpacity(0.6),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
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
                                    onTap: (){
                                      Provider.of<OnOff>(context, listen: false).toggleFinder();
                                    },
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, mulBy: 0.005),
                                  ),
                                  Container(
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
                                  SizedBox(
                                    width: screenWidth(context, mulBy: 0.005),
                                  ),
                                  Container(
                                    height: 11.5,
                                    width: 11.5,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight(context, mulBy: 0.035),
                              ),
                              Text(
                                "Favourites",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "SF",
                                  color: Colors.black38,
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
                                ),),
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
                                ),),
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
                                ),),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = "Movies";
                                  });
                                },
                                child: LeftPaneItems(
                                  iName: "Movies",
                                  isSelected: (selected == "Movies") ? true : false,
                                ),),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = "Music";
                                  });
                                },
                                child: LeftPaneItems(
                                  iName: "Music",
                                  isSelected: (selected == "Music") ? true : false,
                                ),),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = "Pictures";
                                  });
                                },
                                child: LeftPaneItems(
                                  iName: "Pictures",
                                  isSelected: (selected == "Pictures") ? true : false,
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )):Container();
  }

  Container finderWindow(BuildContext context) {
    return Container(
          width: screenWidth(context, mulBy: 0.55),
          height: screenHeight(context, mulBy: 0.65),
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
          child: Row(
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
                        color: Colors.white.withOpacity(0.6),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
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
                              onTap: (){
                                Provider.of<OnOff>(context, listen: false).toggleFinder();
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            Container(
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
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            Container(
                              height: 11.5,
                              width: 11.5,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.035),
                        ),
                        Text(
                          "Favourites",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "SF",
                            color: Colors.black38,
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
                        ),),
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
                        ),),
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
                        ),),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Movies";
                            });
                          },
                          child: LeftPaneItems(
                          iName: "Movies",
                          isSelected: (selected == "Movies") ? true : false,
                        ),),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Music";
                            });
                          },
                          child: LeftPaneItems(
                          iName: "Music",
                          isSelected: (selected == "Music") ? true : false,
                        ),),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "Pictures";
                            });
                          },
                          child: LeftPaneItems(
                          iName: "Pictures",
                          isSelected: (selected == "Pictures") ? true : false,
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
              )
            ],
          ),
        );
  }
}

