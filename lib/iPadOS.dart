import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/apps/launchpad.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/folders.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/rightClickMenu.dart';
import 'package:mac_dt/sizes.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:flutter/rendering.dart';
import 'components/notifiaction.dart';
import 'openApps.dart';
import 'theme/theme.dart';
import 'components/dock.dart';
import 'fileMenu/fileMenu.dart';

class IPadOS extends StatefulWidget {
  @override
  _IPadOSState createState() => _IPadOSState();
}

class _IPadOSState extends State<IPadOS> {
  bool finderOpen = true;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool ccOpen = Provider.of<OnOff>(context).getCc;
    double brightness = Provider.of<DataBus>(context).getBrightness;
    List<Widget> apps = Provider.of<Apps>(context).getApps;
    List<Folder> folders =
        Provider.of<Folders>(context, listen: false).getFolders;
    var pointerPos = Provider.of<DataBus>(context).getPos;
    bool NSOn = Provider.of<DataBus>(
      context,
    ).getNS;
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            ///wallpaper
            GestureDetector(
              onSecondaryTap: () {
                Provider.of<OnOff>(context, listen: false).onRCM();
              },
              onSecondaryTapDown: (details) {
                tapFunctions(context);
                Provider.of<DataBus>(context, listen: false)
                    .setPos(details?.globalPosition);
              },
              onTap: () {
                if (!mounted) return;
                tapFunctions(context);
              },
              child: Container(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    themeNotifier.isDark()
                        ? "assets/wallpapers/iPadOS_dark.jpg"
                        : "assets/wallpapers/iPadOS_light.jpg",
                    fit: BoxFit.cover,
                  )),
            ),

            ///Desktop Items
            ...folders,

            ///Right Click Context Menu
            RightClick(initPos: pointerPos),

            ///Folder Right Click Menu
            FolderRightClick(
              initPos: pointerPos,
            ),

            ///Applications
            ...apps,

            /// file menu
            FileMenu(),

            ///Notification
            Notifications(),

            //TODO State change of widgets under this will cause iFrame HTMLView to reload. Engine Fix required.
            /// Track the issue here: https://github.com/flutter/flutter/issues/80524

            ///LaunchPad
            LaunchPad(),

            ///docker bar
            Docker(),

            ///Control Centre
            Positioned(
              top: screenHeight(context, mulBy: 0.035),
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight(context, mulBy: 0.007),
                      horizontal: screenWidth(context, mulBy: 0.005)),
                  height: screenHeight(context) -
                      (screenHeight(context, mulBy: 0.140)),
                  width: screenWidth(context),
                  child: ControlCentre()),
            ),

            ///Control Night Shift
            IgnorePointer(
              ignoring: true,
              child: BlendMask(
                opacity: 1.0,
                blendMode: BlendMode.colorBurn,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  width: screenWidth(context),
                  height: screenHeight(context),
                  color: Colors.orange.withOpacity(NSOn ? 0.2 : 0),
                ),
              ),
            ),

            ///Control Brightness
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 1 - (brightness / 95.98),
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
