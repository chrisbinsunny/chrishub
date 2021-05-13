import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnOff extends ChangeNotifier{
  bool finderOpen =false;

  bool get getFinder {
    return finderOpen;
  }

  void toggleFinder() {
    finderOpen= !finderOpen;
    notifyListeners();
  }
}