import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import 'sizes.dart';


class Folders extends ChangeNotifier{

  Widget temp;
  List<Folder> folders= [];
  StreamController<int> _controller = StreamController<int>();

  List<Folder> get getFolders {
    return folders;
  }


  void createFolder(context, {String name="untitled folder", bool renaming}){
    Offset initPos=  Offset(200, 150);
    int x,y,i=0;
    if(folders.isEmpty)
      initPos=Offset(screenWidth(context, mulBy: 0.91), screenHeight(context, mulBy: 0.11));
    else{
      folders.forEach((element) {
        if(element.name==name) {
          if(int.tryParse(element.name.split(" ").last)!=null) {
            i = int.parse(element.name.split(" ").last) ?? i;
            name = "${name.substring(0, name.lastIndexOf(" "))} ${++i}";
          }
          else{
            name = "$name ${++i}";
          }
        }
      });
      x= ((folders.length)/6).toInt();
      y= (folders.length)%6;
      print("$x, $y");
      if(x==0)
        initPos=Offset(screenWidth(context, mulBy: 0.91), y*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.11));
      else
        initPos=Offset(screenWidth(context, mulBy: 0.98)-(x+1)*screenWidth(context, mulBy: 0.07), (y)*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.11));

    }
    folders.add(Folder(name: name, renaming: renaming, initPos: initPos, stream: _controller.stream,));
    notifyListeners();
  }

  void deleteFolder(String name){
    folders.removeWhere((element) => element.name==name);
    notifyListeners();
  }

  void deSelectAll(){
    folders.forEach((element) {
      element.deSelectFolder();
    });
  }
}

class Folder extends StatefulWidget {
  String name;
  final Offset initPos;
  bool renaming;
  bool selected;
  final Stream<int> stream;
  VoidCallback deSelectFolder;
  Folder({Key key, this.name, this.initPos, this.renaming= false, this.selected=false, @required this.stream});
  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  Offset position= Offset(200, 150);
  TextEditingController controller;
  FocusNode _focusNode = FocusNode();
  bool pan= false;
  bool bgVisible= false;


  @override
  void initState() {
    controller = new TextEditingController(text: widget.name, );
    controller.selection=TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    position=widget.initPos;
    super.initState();
    selectText();
    widget.deSelectFolder= (){
      setState(() {
        widget.selected=false;
        widget.renaming=false;
        widget.name=controller.text.toString();
      });
    };
  }

  void selectText(){
    _focusNode.addListener(() {
      if(_focusNode.hasFocus) {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //selected= !Provider.of<BackBone>(context,).getClearSelection;
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
                    Container(
                        height: screenHeight(context, mulBy: 0.1),
                        width: screenWidth(context, mulBy: 0.048),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.095), width: screenWidth(context, mulBy: 0.059),)),
                    SizedBox(height: screenHeight(context, mulBy: 0.005), ),
                    Container(
                      height: screenHeight(context, mulBy: 0.024),
                      //width: screenWidth(context, mulBy: 0.06),

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff0058d0),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Text(widget.name??"", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "HN", fontWeight: FontWeight.w500, fontSize: 12,), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    )
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
              onPanStart: (e){
                setState(() {
                  widget.renaming=false;
                  widget.selected=true;
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

              onTap: (){
                Provider.of<Folders>(context, listen: false).deSelectAll();
                setState(() {
                  widget.selected=true;
                });
              },
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
                        decoration: (widget.renaming||widget.selected)?BoxDecoration(
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
                      child: Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.085), width: screenWidth(context, mulBy: 0.045), ),
                        ),


            SizedBox(height: screenHeight(context, mulBy: 0.005), ),
                    widget.renaming?
                    Container(
                      height: screenHeight(context, mulBy: 0.024),
                     // width: screenWidth(context, mulBy: 0.06),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                          ],
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
                    :Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: screenHeight(context, mulBy: 0.024),
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

// class FolderProps{
//   String name;
//   Offset initPos= new Offset(0, 0);
//   bool renaming;
//
//   FolderProps({this.name="", this.initPos, this.renaming= false});
// }

