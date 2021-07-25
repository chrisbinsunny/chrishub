import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/sizes.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'openApps.dart';
import 'theme/theme.dart';
import 'components/docker.dart';
import 'fileMenu/fileMenu.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool finderOpen = true;



  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool ccOpen= Provider.of<OnOff>(context).getCc;
    double brightness = Provider.of<BackBone>(context).getBrightness;
    List<Widget> apps= Provider.of<Apps>(context).getApps;

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            //wallpaper
            Container(
                height:size.height,
                width: size.width,
                child: Image.asset(themeNotifier.isDark()?"assets/wallpapers/bigsur_dark.jpg":"assets/wallpapers/bigsur_light.jpg",  fit: BoxFit.cover,)),

            Stack(
              children: apps,
            ),

            // file menu
            FileMenu(),

            //TODO State change of widgets under this will cause iFrame HTMLView to reload. Engine Fix required.
            /// Track the issue here: https://github.com/flutter/flutter/issues/80524

            //docker bar
            Docker(),

            //Click to dismiss Control Centre
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

            //Control Brightness
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 1-(brightness/95.98),
                child: Container(
                  width: screenWidth(context),
                  height: screenHeight(context),
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



