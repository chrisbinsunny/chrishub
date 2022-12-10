import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mac_dt/system/folders/folders_CRUD.dart';
import 'package:provider/provider.dart';

import '../../apps/systemPreferences.dart';
import '../../data/analytics.dart';
import '../componentsOnOff.dart';
import '../../providers.dart';
import '../../sizes.dart';
import '../openApps.dart';
part 'folders.g.dart';


class Folders extends ChangeNotifier{

  Widget? temp;
  List<Folder> folders= FoldersDataCRUD.getFolders();

  List<DesktopItem> desktopItems=[];

  List<Folder> get getFolders {
    return folders;
  }

  List<DesktopItem> get getDesktopItems {
    return desktopItems;
  }

  void createFolder(context, {String name="untitled folder", bool? renaming}){
    Offset initPos=  Offset(200, 150);
    int x,y,folderNum=0;
    if(folders.isEmpty)
      initPos=Offset(screenWidth(context, mulBy: 0.91), screenHeight(context, mulBy: 0.09));
    else{
        for(int element=0; element<folders.length; element++) {
        if(folders[element].name==name) {
          if(int.tryParse(folders[element].name!.split(" ").last)!=null) { ///for not changing "untitled folder" to "untitled 1"
            folderNum = int.parse(folders[element].name!.split(" ").last) ?? folderNum;
            name = "${name.substring(0, name.lastIndexOf(" "))} ${++folderNum}";
            element=0;   ///for checking if changed name == name in already checked folders
          }
          else{
            name = "$name ${++folderNum}";
          }
        }
        }
      x= (folders.length)~/6;
      y= (folders.length)%6;
      if(x==0)
        initPos=Offset(screenWidth(context, mulBy: 0.91), y*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.09));
      else
        initPos=Offset(screenWidth(context, mulBy: 0.98)-(x+1)*screenWidth(context, mulBy: 0.07), (y)*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.09));
    }
    log(initPos.dy.toString());
    folders.add(Folder(key: UniqueKey(), name: name, renaming: renaming, initPos: initPos, ));
    FoldersDataCRUD.addFolder(FolderProps(name: name, x: initPos.dx, y: initPos.dy,));
    Provider.of<AnalyticsService>(context, listen: false)
        .logFolder(name);
    notifyListeners();
  }

  void deleteFolder(BuildContext context){
    Offset posAfterDel=  Offset(200, 150);
    int x,y;
    String name=folders.firstWhere((element) => element.selected==true).name!;
    folders.removeWhere((element) => element.selected==true);

    deSelectAll();

    for(int i=0; i<folders.length; i++)
    {
      x= (i)~/6;
      y= (i)%6;
      if(x==0)
        posAfterDel=Offset(screenWidth(context, mulBy: 0.91), y*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.09));
      else
        posAfterDel=Offset(screenWidth(context, mulBy: 0.98)-(x+1)*screenWidth(context, mulBy: 0.07), (y)*screenHeight(context, mulBy: 0.129)+screenHeight(context, mulBy: 0.09));
      folders[i].initPos=posAfterDel;
    }

    FoldersDataCRUD.deleteFolder(name, folders);

    notifyListeners();

  }

  void renameFolder(){
    folders.forEach((element) {
      if(element.selected==true) {

        element.renameFolder();
      }
    });
  }

  void deSelectAll(){

    desktopItems.forEach((element) {
      element.deSelectFolder();
    });

    folders.forEach((element) {
      element.deSelectFolder();
    });
  }


}

class Folder extends StatefulWidget {
  String? name;
  Offset? initPos;
  bool? renaming;
  bool selected;
  late VoidCallback deSelectFolder;
  late VoidCallback renameFolder;
  Folder({Key? key, this.name, this.initPos, this.renaming= false, this.selected=false,}): super(key: key);
  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  Offset? position= Offset(200, 150);
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
    widget.renameFolder=(){
      if (!mounted) return;
      setState(() {
        widget.renaming=true;
      });
    };
    widget.deSelectFolder= (){
      if (!mounted) return;
      setState(() {
        widget.selected=false;
        widget.renaming=false;
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
    List<Folder> folders= Provider.of<Folders>(context).getFolders;
    if(!pan)
    position=widget.initPos;
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Stack(
        children: [
          Visibility(
            visible: bgVisible,
            child: Positioned(
              top: widget.initPos!.dy,
              left: widget.initPos!.dx,
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
                      child: Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.085), width: screenWidth(context, mulBy: 0.045), ),
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
                  widget.renaming=false;
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
                width: screenWidth(context, mulBy: 0.08),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                         height: screenHeight(context, mulBy: 0.1),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(context,mulBy: 0.0005)),
                        decoration: (widget.renaming!||widget.selected)?BoxDecoration(
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
                    widget.renaming!?
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
                            if (!mounted) return;
                            setState(() {
                              widget.renaming=false;
                              if(controller!.text=="")    ///changes controller to sys found name if empty.
                                controller!.text=widget.name!;
                              int folderNum=0;
                              for(int element=0; element<folders.length; element++) {
                                if(folders[element].name==controller!.text) {
                                  if(int.tryParse(folders[element].name!.split(" ").last)!=null) { ///for not changing "untitled folder" to "untitled 1"
                                    folderNum = int.parse(folders[element].name!.split(" ").last) ?? folderNum;
                                    controller!.text = "${controller!.text.substring(0, controller!.text.lastIndexOf(" "))} ${++folderNum}";
                                    element=0;   ///for checking if changed name == name in already checked folders
                                  }
                                  else{
                                    controller!.text = "${controller!.text} ${++folderNum}";
                                  }
                                }
                              }
                              FoldersDataCRUD.renameFolder(widget.name!, controller!.text.toString());
                              widget.name=controller!.text.toString();
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


///Declared as HiveObject for hive database
@HiveType(typeId: 2)
class FolderProps extends HiveObject{

  @HiveField(0,)
  String? name;

  @HiveField(1,)
  double? x;

  @HiveField(2,)
  double? y;


  FolderProps({this.name="", this.x, this.y,});
}

