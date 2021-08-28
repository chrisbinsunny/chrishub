import 'package:flutter/material.dart';
import 'package:mac_dt/widgets.dart';

import 'sizes.dart';


class Folders extends ChangeNotifier{

  Widget temp;
  List<Folder> folders= [
    Folder(name: "New Folder",)
  ];


  List<Folder> get getFolders {
    return folders;
  }

  void createFolder(String name, bool renaming){
    folders.add(Folder(name: name, renaming: renaming,));
    notifyListeners();
  }

  void deleteFolder(String name){
    folders.removeWhere((element) => element.name==name);
    notifyListeners();
  }

}

class Folder extends StatefulWidget {
  String name;
  Offset location= new Offset(300, 150);
  bool renaming;
  Folder({Key key, this.name="", this.location, this.renaming= false});

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/icons/folder.png", height: screenHeight(context, mulBy: 0.1), width: screenWidth(context, mulBy: 0.7),),
            MBPText(text: widget.name, color: Colors.white, fontFamily: "HN", weight: FontWeight.w500, size: 12,),
          ],
        ),
      ),
    );
  }
}

// class FolderProps{
//   String name;
//   Offset location= new Offset(0, 0);
//   bool renaming;
//
//   FolderProps({this.name="", this.location, this.renaming= false});
// }