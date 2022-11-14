

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mac_dt/system/folders/folders.dart';

class FoldersDataCRUD{

  static Box<FolderProps> getFoldersBox() =>
      Hive.box<FolderProps>('folders');


  ///Gets data from local database.
  static List<Folder> getFolders(){

    final box= getFoldersBox();

    List<Folder> folders=[];
    folders=box.values.map((e) => Folder(name: e.name, key: UniqueKey(), initPos: Offset(e.x!, e.y!), renaming:false,)).toList();

    return folders;
  }

  ///Sets data to local database.
  static addFolder(FolderProps? folderProps){

    final box= getFoldersBox();
    box.put(folderProps!.name, folderProps);
  }


  static renameFolder(String oldName, String newName){
    final box= getFoldersBox();
    FolderProps? folderProps= box.get(oldName);
    folderProps!.delete();
    folderProps.name=newName;
    addFolder(folderProps);
  }


  static deleteFolder(String name){
    final box= getFoldersBox();
    FolderProps? folderProps= box.get(name);
    folderProps!.delete();
  }

}