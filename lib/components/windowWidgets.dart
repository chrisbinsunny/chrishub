import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sizes.dart';

class LeftPaneItems extends StatefulWidget {
  bool isSelected;
  final String iName;
  LeftPaneItems({
    this.isSelected=false,
    this.iName,
    Key key,
  }) : super(key: key);

  @override
  _LeftPaneItemsState createState() => _LeftPaneItemsState();
}

class _LeftPaneItemsState extends State<LeftPaneItems> {
  bool hovering= false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (evnt){
        setState(() {
          hovering=true;
        });
      },
      onExit: (evnt){
        setState(() {
          hovering=false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.isSelected?Colors.black.withOpacity(0.14):
          hovering ? Colors.black.withOpacity(0.14) : Colors.transparent
        ,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        alignment: Alignment.centerLeft,
        width: screenWidth(context,),
        padding: EdgeInsets.only(left: screenWidth(context,mulBy: 0.005)),
        height: screenHeight(context,mulBy: 0.038),
        child: Row(
          children: [
            Image.asset("assets/icons/${widget.iName.toLowerCase()}.png", height: 15),
            Text(
              "    ${widget.iName}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}