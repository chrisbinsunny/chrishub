import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers.dart';
import '../sizes.dart';
import '../system/componentsOnOff.dart';
import '../system/folders/folders.dart';

class DesktopItem extends StatefulWidget {
  String? name;
  Offset? initPos;
  bool selected;
  late VoidCallback deSelectFolder;
  VoidCallback onDoubleTap;
  DesktopItem({Key? key, this.name, this.initPos,  this.selected=false, required this.onDoubleTap}): super(key: key);
  @override
  _DesktopItemState createState() => _DesktopItemState();
}

class _DesktopItemState extends State<DesktopItem> {
  Offset? position= Offset(135, 150);
  TextEditingController? controller;
  FocusNode _focusNode = FocusNode();
  bool pan= false;
  bool bgVisible= false;

  @override
  void initState() {
    super.initState();
    controller = new TextEditingController(text: widget.name, );
    controller!.selection=TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
    position=widget.initPos;
    selectText();
    widget.deSelectFolder= (){
      if (!mounted) return;
      setState(() {
        widget.selected=false;
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
    if(!pan)
      position=Offset(screenWidth(context, mulBy: widget.initPos!.dx),screenHeight(context, mulBy: widget.initPos!.dy));
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Stack(
        children: [
          Visibility(
            visible: bgVisible,
            child: Positioned(
              top: screenHeight(context, mulBy: widget.initPos!.dy),
              left: screenWidth(context, mulBy: widget.initPos!.dx),
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
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Image.asset("assets/icons/server.png", height: screenHeight(context, mulBy: 0.085), width: screenWidth(context, mulBy: 0.045), ),
                    ),
                    SizedBox(height: screenHeight(context, mulBy: 0.005), ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight(context, mulBy: 0.024),
                          padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.005)),
                          alignment: Alignment.center,
                          decoration:BoxDecoration(
                              color: Color(0xff0058d0),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Text(widget.name??"", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "HN", fontWeight: FontWeight.w500, fontSize: 12,), maxLines: 1, overflow: TextOverflow.ellipsis, ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: pan?0:200),
            top: position!.dy,
            left: position!.dx,
            child: GestureDetector(
              onDoubleTap: (){
                tapFunctions(context);
                if (!mounted) return;
                setState(() {
                  widget.selected=true;
                });
                widget.onDoubleTap();
              },

              onPanUpdate: (tapInfo){
                if (!mounted) return;
                setState(() {
                  position = Offset(position!.dx + tapInfo.delta.dx,
                      position!.dy + tapInfo.delta.dy);
                });
              },
              onPanStart: (e){
                tapFunctions(context);
                if (!mounted) return;
                setState(() {
                  widget.selected=false;
                  widget.name=controller!.text.toString();
                  pan=true;
                  bgVisible=true;
                });
              },
              onPanEnd: (e){
                if (!mounted) return;
                setState(() {
                  pan=false;
                  position=widget.initPos;
                });
                Timer(Duration(milliseconds: 200), (){
                  if (!mounted) return;
                  setState(() {
                    bgVisible=false;
                    widget.selected=true;
                  });});
              },

              onTap: (){
                tapFunctions(context);
                if (!mounted) return;
                setState(() {
                  widget.selected=true;
                });
              },

              onSecondaryTap: (){
                if (!mounted) return;
                setState(() {
                  widget.selected=true;
                });
                Provider.of<OnOff>(context, listen: false).onFRCM();
              },
              onSecondaryTapDown: (details){
                tapFunctions(context);
                Provider.of<DataBus>(context, listen: false).setPos(details.globalPosition);
              },
              child: Container(
                width: 122,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 74.5,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.0005)),
                      decoration: (widget.selected)?BoxDecoration(
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
                      child: Image.asset("assets/icons/server.png", height: 63.3, width: 69.12, ),
                    ),
                    SizedBox(height: screenHeight(context, mulBy: 0.005), ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 18,
                          padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.005)),
                          alignment: Alignment.center,
                          decoration: widget.selected?BoxDecoration(
                              color: Color(0xff0058d0),
                              borderRadius: BorderRadius.circular(3)
                          ):BoxDecoration(),
                          child: Text(widget.name??"", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "HN", fontWeight: FontWeight.w500, fontSize: 12,), maxLines: 1, overflow: TextOverflow.ellipsis, ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


