import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// var finderOpen = Provider.of<OnOff>(context).getFinder;
// Provider.of<OnOff>(context, listen: false).toggleFinder();

class OnOff extends ChangeNotifier{

  bool ccOpen =false;
  bool finderOpen =false;
  bool finderFS = false;
  bool safariOpen =true;
  bool safariFS = false;
  bool safariPan = false;
  bool finderPan = false;



  bool get getFinder {
    return finderOpen;
  }

  bool get getFinderFS {
    return finderFS;
  }

  void toggleFinder() {
    finderOpen= !finderOpen;
    notifyListeners();
  }

  void toggleFinderFS() {
    finderFS= !finderFS;
    notifyListeners();
  }
  void offFinderFS() {
    finderFS= false;
    notifyListeners();
  }

  void openFinder() {
    finderOpen= true;
    notifyListeners();
  }

  bool get getFinderPan {
    return finderPan;
  }
  void offFinderPan() {
    finderPan= false;
    notifyListeners();
  }

  void onFinderPan() {
    finderPan= true;
    notifyListeners();
  }

  bool get getSafari {
    return safariOpen;
  }

  bool get getSafariFS {
    return safariFS;
  }

  void toggleSafari() {
    safariOpen= !safariOpen;
    notifyListeners();
  }

  void toggleSafariFS() {
    safariFS= !safariFS;
    notifyListeners();
  }
  void offSafariFS() {
    safariFS= false;
    notifyListeners();
  }

  void openSafari() {
    safariOpen= true;
    notifyListeners();
  }

  bool get getSafariPan {
    return safariPan;
  }
  void offSafariPan() {
    safariPan= false;
    notifyListeners();
  }

  void onSafariPan() {
    safariPan= true;
    notifyListeners();
  }

  bool get getCc {
    return ccOpen;
  }

  void toggleCc() {
    ccOpen= !ccOpen;
    notifyListeners();
  }

}