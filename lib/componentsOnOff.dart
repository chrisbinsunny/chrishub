import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// var finderOpen = Provider.of<OnOff>(context).getFinder;
// Provider.of<OnOff>(context, listen: false).toggleFinder();

class OnOff extends ChangeNotifier{

  String onTop="finder";
  String fs="";
  bool ccOpen =false;
  bool finderOpen =false;
  bool finderFS = false;
  bool safariOpen =false;
  bool safariFS = false;
  bool safariPan = false;
  bool finderPan = false;
  bool vsOpen = false;
  bool vsFS = false;
  bool vsPan = false;
  bool spotifyOpen = false;
  bool spotifyFS = false;
  bool spotifyPan = false;
  bool fsAni= false;
  bool feedBackOpen = false;
  bool feedBackFS = false;
  bool feedBackPan = false;
  bool calendarOpen = false;
  bool calendarFS = false;
  bool calendarPan = false;
  bool terminalOpen = true;
  bool terminalFS = false;
  bool terminalPan = false;

  String get getFS {
    return fs;
  }

  bool get getFSAni{
  return fsAni;
}

  String get getTop {
    return onTop;
  }

  set setTop(top) {
    onTop=top;
    notifyListeners();
  }

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
    bool localFs= fsAni;
    finderFS= !finderFS;
    fs=(fs=="")?"Finder":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offFinderFS() {
    finderFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
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
    bool localFs= fsAni;
    safariFS= !safariFS;
    fs=(fs=="")?"Safari":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offSafariFS() {
    safariFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
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

  bool get getVS {
    return vsOpen;
  }

  bool get getVSFS {
    return vsFS;
  }

  void toggleVS() {
    vsOpen= !vsOpen;
    notifyListeners();
  }

  void toggleVSFS() {
    bool localFs= fsAni;
    vsFS= !vsFS;
    fs=(fs=="")?"VS Code":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offVSFS() {
    vsFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void openVS() {
    vsOpen= true;
    notifyListeners();
  }

  bool get getVSPan {
    return vsPan;
  }

  void offVSPan() {
    vsPan= false;
    notifyListeners();
  }

  void onVSPan() {
    vsPan= true;
    notifyListeners();
  }

  bool get getSpotify {
    return spotifyOpen;
  }

  bool get getSpotifyFS {
    return spotifyFS;
  }

  void toggleSpotify() {
    spotifyOpen= !spotifyOpen;
    notifyListeners();
  }

  void toggleSpotifyFS() {
    bool localFs= fsAni;
    spotifyFS= !spotifyFS;
    fs=(fs=="")?"Spotify":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offSpotifyFS() {
    spotifyFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void openSpotify() {
    spotifyOpen= true;
    notifyListeners();
  }

  bool get getSpotifyPan {
    return spotifyPan;
  }

  void offSpotifyPan() {
    spotifyPan= false;
    notifyListeners();
  }

  void onSpotifyPan() {
    spotifyPan= true;
    notifyListeners();
  }

  bool get getCalendar {
    return calendarOpen;
  }

  bool get getCalendarFS {
    return calendarFS;
  }

  void toggleCalendar() {
    calendarOpen= !calendarOpen;
    notifyListeners();
  }

  void toggleCalendarFS() {
    bool localFs= fsAni;
    calendarFS= !calendarFS;
    fs=(fs=="")?"Calendar":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offCalendarFS() {
    calendarFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void openCalendar() {
    calendarOpen= true;
    notifyListeners();
  }

  bool get getCalendarPan {
    return calendarPan;
  }

  void offCalendarPan() {
    calendarPan= false;
    notifyListeners();
  }

  void onCalendarPan() {
    calendarPan= true;
    notifyListeners();
  }

  bool get getTerminal {
    return terminalOpen;
  }

  bool get getTerminalFS {
    return terminalFS;
  }

  void toggleTerminal() {
    terminalOpen= !terminalOpen;
    notifyListeners();
  }

  void toggleTerminalFS() {
    bool localFs= fsAni;
    terminalFS= !terminalFS;
    fs=(fs=="")?"Terminal":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offTerminalFS() {
    terminalFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void openTerminal() {
    terminalOpen= true;
    notifyListeners();
  }

  bool get getTerminalPan {
    return terminalPan;
  }

  void offTerminalPan() {
    terminalPan= false;
    notifyListeners();
  }

  void onTerminalPan() {
    terminalPan= true;
    notifyListeners();
  }

  bool get getFeedBack {
    return feedBackOpen;
  }

  bool get getFeedBackFS {
    return feedBackFS;
  }

  void toggleFeedBack() {
    feedBackOpen= !feedBackOpen;
    notifyListeners();
  }

  void toggleFeedBackFS() {
    bool localFs= fsAni;
    feedBackFS= !feedBackFS;
    fs=(fs=="")?"Feedback":"";
    if(!localFs){
      fsAni = true;
    }
    notifyListeners();
    if(localFs){
      Future.delayed(Duration(milliseconds: 400), () {
        fsAni = false;
        notifyListeners();
      });
    }
  }

  void offFeedBackFS() {
    feedBackFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void openFeedBack() {
    feedBackOpen= true;
    notifyListeners();
  }

  bool get getFeedBackPan {
    return feedBackPan;
  }

  void offFeedBackPan() {
    feedBackPan= false;
    notifyListeners();
  }

  void onFeedBackPan() {
    feedBackPan= true;
    notifyListeners();
  }

  bool get getCc {
    return ccOpen;
  }

  void toggleCc() {
    ccOpen= !ccOpen;
    notifyListeners();
  }

  void offCc() {
    ccOpen= false;
    notifyListeners();
  }

}