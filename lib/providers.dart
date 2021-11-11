import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'componentsOnOff.dart';
import 'folders.dart';

// var finderOpen = Provider.of<OnOff>(context).getFinder;
// Provider.of<OnOff>(context, listen: false).toggleFinder();

class DataBus extends ChangeNotifier{

  String onTop="finder";
  String fs="";
  double brightness =95.98;
  Offset pointerPos = new Offset(0, 0);
  bool nightShift= false;
  Map<String, String> notification= {
    "notification":"Welcome to Chrisbin's MacBook Pro",
    "url":"https://github.com/chrisbinsunny",
    "app":"apple",
    "head":"Welcome"
  };



  double get getBrightness {
    return brightness;
  }


  void setBrightness(double val) {
    brightness= val;
    notifyListeners();
  }

  Offset get getPos {
    return pointerPos;
  }


  void setPos(Offset val) {
    pointerPos= val;
    notifyListeners();
  }

  void setNotification(String noti, url, app, head){
    notification["notification"]=noti;
    notification["url"]=url;
    notification["app"]=app;
    notification["head"]=head;
    notifyListeners();
  }

  get getNotification => notification;


  void toggleNS(){
    nightShift=!nightShift;
    notifyListeners();
  }

  get getNS => nightShift;
}

void tapFunctions(BuildContext context){
  Provider.of<Folders>(context, listen: false).deSelectAll();
  Provider.of<OnOff>(context, listen: false).offNotifications();
  Provider.of<OnOff>(context, listen: false).offFRCM();
  Provider.of<OnOff>(context, listen: false).offRCM();
  Provider.of<OnOff>(context, listen: false).offLaunchPad();
}