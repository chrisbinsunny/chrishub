import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// var finderOpen = Provider.of<OnOff>(context).getFinder;
// Provider.of<OnOff>(context, listen: false).toggleFinder();

/// toggle{App}() toggles between the minimized and regular view of the app. Opening
/// the app is managed by Apps state management.


class OnOff extends ChangeNotifier{

  String fs="";
  bool ccOpen =false;
  bool finderMax =false;
  bool finderFS = false;
  bool safariMax =false;
  bool safariFS = false;
  bool safariPan = false;
  bool finderPan = false;
  bool vsMax = false;
  bool vsFS = false;
  bool vsPan = false;
  bool spotifyMax = false;
  bool spotifyFS = false;
  bool spotifyPan = false;
  bool fsAni= false;
  bool feedBackOpen = false;
  bool feedBackFS = false;
  bool feedBackPan = false;
  bool aboutOpen = false;
  bool aboutFS = false;
  bool aboutPan = false;
  bool calendarMax = false;
  bool calendarFS = false;
  bool calendarPan = false;
  bool terminalMax = false;
  bool terminalFS = false;
  bool terminalPan = false;
  bool messagesMax = false;
  bool messagesFS = false;
  bool messagesPan = false;
  bool rightClickMenu = false;
  bool folderRightClickMenu = false;
  bool notificationOn =false;
  bool launchPadOn=false;
  bool appOpen=false;
  bool sysPrefOpen = false;
  bool sysPrefPan = false;

  bool get getAppOpen {
    return appOpen;
  }

  void toggleAppOpen(){
    appOpen=!appOpen;
    notifyListeners();
  }

  String get getFS {
    return fs;
  }

  bool get getFSAni{
  return fsAni;
}


  bool get getFinder {
    return finderMax;
  }

  bool get getFinderFS {
    return finderFS;
  }

  void toggleFinder() {
    finderMax= !finderMax;
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

  void maxFinder() {
    finderMax= true;
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
    return safariMax;
  }

  bool get getSafariFS {
    return safariFS;
  }

  void toggleSafari() {
    safariMax= !safariMax;
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

  void maxSafari() {
    safariMax= true;
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
    return vsMax;
  }

  bool get getVSFS {
    return vsFS;
  }

  void toggleVS() {
    vsMax= !vsMax;
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

  void maxVS() {
    vsMax= true;
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
    return spotifyMax;
  }

  bool get getSpotifyFS {
    return spotifyFS;
  }

  void toggleSpotify() {
    spotifyMax= !spotifyMax;
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

  void maxSpotify() {
    spotifyMax= true;
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
    return calendarMax;
  }

  bool get getCalendarFS {
    return calendarFS;
  }

  void toggleCalendar() {
    calendarMax= !calendarMax;
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

  void maxCalendar() {
    calendarMax= true;
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
    return terminalMax;
  }

  bool get getTerminalFS {
    return terminalFS;
  }

  void toggleTerminal() {
    terminalMax= !terminalMax;
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

  void maxTerminal() {
    terminalMax= true;
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

  bool get getMessages {
    return messagesMax;
  }

  bool get getMessagesFS {
    return messagesFS;
  }

  void toggleMessages() {
    messagesMax= !messagesMax;
    notifyListeners();
  }

  void toggleMessagesFS() {
    bool localFs= fsAni;
    messagesFS= !messagesFS;
    fs=(fs=="")?"Messages":"";
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

  void offMessagesFS() {
    messagesFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void maxMessages() {
    messagesMax= true;
    notifyListeners();
  }

  bool get getMessagesPan {
    return messagesPan;
  }

  void offMessagesPan() {
    messagesPan= false;
    notifyListeners();
  }

  void onMessagesPan() {
    messagesPan= true;
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

  void maxFeedBack() {
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

  bool get getAbout {
    return aboutOpen;
  }

  bool get getAboutFS {
    return aboutFS;
  }

  void toggleAbout() {
    aboutOpen= !aboutOpen;
    notifyListeners();
  }

  void toggleAboutFS() {
    bool localFs= fsAni;
    aboutFS= !aboutFS;
    fs=(fs=="")?"About Me":"";
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

  void offAboutFS() {
    aboutFS= false;
    fs="";
    notifyListeners();
    Future.delayed(Duration(milliseconds: 400),(){
      fsAni=false;
      notifyListeners();
    });
  }

  void maxAbout() {
    aboutOpen= true;
    notifyListeners();
  }

  bool get getAboutPan {
    return aboutPan;
  }

  void offAboutPan() {
    aboutPan= false;
    notifyListeners();
  }

  void onAboutPan() {
    aboutPan= true;
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

  bool get getRCM {
    return rightClickMenu;
  }

  void onRCM() {
    rightClickMenu= true;
    notifyListeners();
  }

  void offRCM() {
    rightClickMenu= false;
    notifyListeners();
  }

  bool get getFRCM {
    return folderRightClickMenu;
  }

  void onFRCM() {
    folderRightClickMenu= true;
    notifyListeners();
  }

  void offFRCM() {
    folderRightClickMenu= false;
    notifyListeners();
  }

  void onNotifications() {
    notificationOn= true;
    Future.delayed(Duration(seconds: 4), (){
      offNotifications();
    });
    notifyListeners();
  }

  void offNotifications() {
    notificationOn= false;
    notifyListeners();
  }


  bool get getSysPref {
    return sysPrefOpen;
  }



  void toggleSysPref() {
    sysPrefOpen= !sysPrefOpen;
    notifyListeners();
  }

  void maxSysPref() {
    sysPrefOpen= true;
    notifyListeners();
  }

  bool get getSysPrefPan {
    return sysPrefPan;
  }

  void offSysPrefPan() {
    sysPrefPan= false;
    notifyListeners();
  }

  void onSysPrefPan() {
    sysPrefPan= true;
    notifyListeners();
  }


  get getNotificationOn=> notificationOn;

  void toggleLaunchPad() {
    launchPadOn= !launchPadOn;
    notifyListeners();
  }

  void offLaunchPad() {
    launchPadOn= false;
    notifyListeners();
  }

  get getLaunchPad => launchPadOn;
}