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
  TextEditingController controller = new TextEditingController(text: "Untitled Folder");
  final _focusNode = FocusNode();
  bool selected= false;

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
    selected= false;
    print
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: GestureDetector(
        onPanUpdate: (tapInfo){
          setState(() {
            position = Offset(position.dx + tapInfo.delta.dx,
                position.dy + tapInfo.delta.dy);
          });
        },
        onTap: (){
          setState(() {
            selected=true;
          });
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.1), width: screenWidth(context, mulBy: 0.06),),
              widget.renaming?
                  Container(
                    height: screenHeight(context, mulBy: 0.025),
                    width: screenWidth(context, mulBy: 0.06),
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
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
                  )
              :MBPText(text: widget.name, color: Colors.white, fontFamily: "HN", weight: FontWeight.w500, size: 12,),
            ],
          ),
        ),
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