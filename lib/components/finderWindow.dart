import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/sizes.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Color caughtColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
          DragBox(Offset(150.0, 0.0), 'Box Two', Colors.orange),
          DragBox(Offset(300.0, 0.0), 'Box Three', Colors.lightGreen),
          Positioned(
            left: 125.0,
            bottom: 0.0,
            child: DragTarget(
              onAccept: (Color color) {
                caughtColor = color;
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: accepted.isEmpty
                        ? caughtColor
                        : Colors.deepPurple.shade200,
                  ),
                  child: Center(
                    child: Text("Drag Here!",
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: screenWidth(context, mulBy: 0.55),
            height: screenHeight(context, mulBy: 0.65),
            decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.013),
                          vertical: screenHeight(context, mulBy: 0.025)),
                      height: screenHeight(context),
                      width: screenWidth(context, mulBy: 0.13),
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
                              Container(
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
                          ),SizedBox(
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
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.14),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.centerLeft,
                            width: screenWidth(context,),
                            height: screenHeight(context,mulBy: 0.038),
                            child: Text(
                              "    Applications",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.14),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.centerLeft,
                            width: screenWidth(context,),
                            height: screenHeight(context,mulBy: 0.038),
                            child: Text(
                              "    Applications",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
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
                color: Colors.white,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}
