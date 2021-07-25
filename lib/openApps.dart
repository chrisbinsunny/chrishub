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

  void bringToTop(ObjectKey app){
    temp= apps.singleWhere((element) => element.key==app);
    apps.removeWhere((element) => element.key==app);
    apps.add(temp);
  }

  List<Widget> get getApps {
    return apps;
  }

  void openApp(Widget app){
    apps.add(app);
    notifyListeners();
  }

}

Apps appVar= new Apps();

// class AppStack extends StatefulWidget {
//   const AppStack({Key key}) : super(key: key);
//
//   @override
//   _AppStackState createState() => _AppStackState();
// }
//
// class _AppStackState extends State<AppStack> {
//
//   Widget temp;
//   List<Widget> apps= [];
//
//   void bringToTop(ObjectKey app){
//     temp= apps.singleWhere((element) => element.key==app);
//     apps.removeWhere((element) => element.key==app);
//     apps.add(temp);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         apps.add(Finder(key: ObjectKey("finder"), initPos: Offset(screenWidth(context,mulBy:0.2),screenHeight(context,mulBy: 0.18))));
//         apps.add(Safari(key: ObjectKey("safari"), initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))));
//         //VSCodeWindow
//         apps.add(VSCode(key: ObjectKey("vscode"), initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))));
//         //SpotifyWindow
//         apps.add(Spotify(key: ObjectKey("spotify"), initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))));
//         //FeedBack Window
//         apps.add(FeedBack(initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))));
//         //Calendar Window
//         apps.add(Calendar(key: ObjectKey("calendar"), initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))));
//         //Terminal Window
//         apps.add(Terminal(key: ObjectKey("terminal"), initPos: Offset(screenWidth(context,mulBy:0.28),screenHeight(context,mulBy: 0.2))));
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: apps,
//     );
//   }
// }
