import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'apps/calendar.dart';
import 'apps/feedback/feedback.dart';
import 'apps/spotify.dart';
import 'apps/terminal/terminal.dart';
import 'apps/vscode.dart';
import 'components/finderWindow.dart';
import 'componentsOnOff.dart';
import 'safari/safariWindow.dart';
import 'sizes.dart';


class Apps extends ChangeNotifier{

  Widget temp;
  List<Widget> apps= [];
  String onTop="Finder";


  void bringToTop(ObjectKey appKey){
    temp= apps.singleWhere((element) => element.key==appKey);
    apps.removeWhere((element) => element.key==appKey);
    apps.add(temp);
    setTop();
    notifyListeners();
  }

  List<Widget> get getApps {
    return apps;
  }

  void openApp(Widget app, void minMax){
    if(!apps.any((element) => element.key==app.key)) {
      apps.add(app);
      setTop();
      notifyListeners();
    }
    else {
      bringToTop(app.key);
      minMax;
    }
  }

  void closeApp(String appKey){

    apps.removeWhere((element) => element.key==ObjectKey(appKey));
    notifyListeners();
    setTop();
  }

  bool isOpen(ObjectKey appKey){
    return apps.any((element) => element.key==appKey);
  }

  String get getTop {
    return onTop;
  }

  void setTop() {
    //onTop=top;
    if(apps.isEmpty)
      onTop="Finder";
    else if(apps.last.key==ObjectKey("finder"))
     onTop="Finder";
    else if(apps.last.key==ObjectKey("safari"))
      onTop="Safari";
    else if(apps.last.key==ObjectKey("spotify"))
      onTop="Spotify";
    else if(apps.last.key==ObjectKey("terminal"))
      onTop="Terminal";
    else if(apps.last.key==ObjectKey("vscode"))
      onTop="VS Code";
    else if(apps.last.key==ObjectKey("calendar"))
      onTop="Calendar";
    else if(apps.last.key==ObjectKey("feedback"))
      onTop="Feedback";

    notifyListeners();
  }

}
