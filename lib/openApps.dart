import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'apps/calendar.dart';
import 'apps/feedback/feedback.dart';
import 'apps/spotify.dart';
import 'apps/terminal/terminal.dart';
import 'apps/vscode.dart';
import 'components/finderWindow.dart';
import 'safari/safariWindow.dart';
import 'sizes.dart';


class Apps extends ChangeNotifier{

  Widget temp;
  List<Widget> apps= [];

  void bringToTop(ObjectKey appKey){
    temp= apps.singleWhere((element) => element.key==appKey);
    apps.removeWhere((element) => element.key==appKey);
    apps.add(temp);
    notifyListeners();
  }

  List<Widget> get getApps {
    return apps;
  }

  void openApp(Widget app){
    if(!apps.any((element) => element.key==app.key)) {
      apps.add(app);
      notifyListeners();
    }
    else
      bringToTop(app.key);
  }

  void closeApp(String appKey){

    apps.removeWhere((element) => element.key==ObjectKey(appKey));
    notifyListeners();
  }

}
