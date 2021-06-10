import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/safari/safariWindow.dart';
import 'package:mac_dt/sizes.dart';
import 'package:provider/provider.dart';

import 'apps/spotify.dart';
import 'apps/vscode.dart';
import 'theme/theme.dart';
import 'components/docker.dart';
import 'components/finderWindow.dart';
import 'fileMenu/fileMenu.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool finderOpen = true;
  ValueNotifier<List<double>> posValueListener = ValueNotifier([0.0, 0.0]);
  ValueChanged<List<double>> posValueChanged;

  


  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool ccOpen= Provider.of<OnOff>(context).getCc;

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            //wallpaper
            Container(
                height:size.height,
                width: size.width,
                child: Image.asset(themeNotifier.isDark()?"assets/wallpapers/bigsur_dark.jpg":"assets/wallpapers/bigsur_light.jpg",  fit: BoxFit.cover,)),
            //FinderWindow
            Finder(initPos: Offset(screenWidth(context,mulBy:0.2),screenHeight(context,mulBy: 0.18))),
            //SafariWindow
            Safari(initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))),
            //VSCodeWindow
            VSCode(initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))),
            //SpotifyWindow
            Spotify(initPos: Offset(screenWidth(context,mulBy:0.14),screenHeight(context,mulBy: 0.1))),
            // file menu
            FileMenu(),
            //docker bar
            Docker(),

            ccOpen?InkWell(
              onTap: (){
                Provider.of<OnOff>(context, listen: false).offCc();
              },
              child: Container(
              height: screenHeight(context),
              width: screenWidth(context),
            ),):Container(),
            //Control Centre
            Positioned(
              top: screenHeight(context,mulBy: 0.035),
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context,mulBy: 0.007),
                    horizontal: screenWidth(context, mulBy: 0.005)
                  ),
                  height: screenHeight(context)-(screenHeight(context, mulBy: 0.140)),
                  width: screenWidth(context),
                  child: ControlCentre()
              ),
            ),
          ],
        ),
      ),
    );
  }
}



