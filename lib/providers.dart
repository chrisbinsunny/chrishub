import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// var finderOpen = Provider.of<OnOff>(context).getFinder;
// Provider.of<OnOff>(context, listen: false).toggleFinder();

class BackBone extends ChangeNotifier{

  String onTop="finder";
  String fs="";
  double brightness =95.98;
  Offset pointerPos = new Offset(0, 0);
  bool clearSelection= true;



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

  bool get getClearSelection {
    return clearSelection;
  }


  void deskClearSelection() {
    clearSelection=true;
    notifyListeners();
  }
}