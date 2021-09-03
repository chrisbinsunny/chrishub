import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import 'sizes.dart';


class Folders extends ChangeNotifier{

  Widget temp;
  List<Folder> folders= [
    //Folder(name: "New Folder", initPos: Offset(200, 150))
  ];


  List<Folder> get getFolders {
    return folders;
  }

  void createFolder(context, {String name, bool renaming}){
    Offset initPos=  Offset(200, 150);
    int x,y;
    if(folders.isEmpty)
      initPos=Offset(screenWidth(context, mulBy: 0.92), screenHeight(context, mulBy: 0.12));
    else{
      x= ((folders.length)/6).toInt();
      y= (folders.length)%6;
      print("$x, $y");
      if(x==0)
        initPos=Offset(screenWidth(context, mulBy: 0.92), (y+1)*screenHeight(context, mulBy: 0.12));
      else
        initPos=Offset(screenWidth(context, mulBy: 0.98)-(x+1)*screenWidth(context, mulBy: 0.06), (y+1)*screenHeight(context, mulBy: 0.12));

    }
    folders.add(Folder(name: name, renaming: renaming, initPos: initPos,));
    notifyListeners();
  }

  void deleteFolder(String name){
    folders.removeWhere((element) => element.name==name);
    notifyListeners();
  }

}

class Folder extends StatefulWidget {
  String name;
  final Offset initPos;
  bool renaming;
  Folder({Key key, this.name="", this.initPos, this.renaming= false});
  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  Offset position= Offset(200, 150);
  TextEditingController controller = new TextEditingController(text: "untitled folder");
  final _focusNode = FocusNode();
  bool pan= false;
  bool bgVisible= false;


  @override
  void initState() {
    position=widget.initPos;
    super.initState();
    selectAll();
  }

  void selectAll(){
    _focusNode.addListener(() {
      if(_focusNode.hasFocus) {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Stack(
        children: [
          Visibility(
            visible: bgVisible,
            child: Positioned(
              top: widget.initPos.dy,
              left: widget.initPos.dx,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.1), width: screenWidth(context, mulBy: 0.06),),
                    MBPText(text: widget.name, color: Colors.white, fontFamily: "HN", weight: FontWeight.w500, size: 12,),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: pan?0:200),
            top: position.dy,
            left: position.dx,
            child: GestureDetector(
              onPanUpdate: (tapInfo){
                setState(() {
                  position = Offset(position.dx + tapInfo.delta.dx,
                      position.dy + tapInfo.delta.dy);
                });
              },
              onPanDown: (e){
                setState(() {
                  widget.renaming=false;
                  widget.name=controller.text.toString();
                  pan=true;
                  bgVisible=true;
                });
              },
              onPanEnd: (e){
                setState(() {
                  pan=false;
                  position=widget.initPos;
                });
                Timer(Duration(milliseconds: 200), (){setState(() {
                  bgVisible=false;
                });});
              },

              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: screenHeight(context, mulBy: 0.1),
                        width: screenWidth(context, mulBy: 0.048),
                        decoration: widget.renaming?BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(4)
                        ):BoxDecoration(),
                        child: Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.095), width: screenWidth(context, mulBy: 0.059),)),
                    SizedBox(height: screenHeight(context, mulBy: 0.005), ),
                    widget.renaming?
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
                            setState(() {
                              widget.renaming=false;
                              widget.name=controller.text.toString();
                            });
                          },
                        ),
                      ),
                    )
                        :MBPText(text: widget.name, color: Colors.white, fontFamily: "HN", weight: FontWeight.w500, size: 12,),
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

// class FolderProps{
//   String name;
//   Offset initPos= new Offset(0, 0);
//   bool renaming;
//
//   FolderProps({this.name="", this.initPos, this.renaming= false});
// }

