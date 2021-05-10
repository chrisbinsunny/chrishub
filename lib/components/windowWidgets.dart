import 'package:flutter/material.dart';

import '../sizes.dart';

class LeftPaneItems extends StatefulWidget {
  final bool isSelected;
  final String iName;
  const LeftPaneItems({
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
        height: screenHeight(context,mulBy: 0.038),
        child: Text(
          "    ${widget.iName}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}