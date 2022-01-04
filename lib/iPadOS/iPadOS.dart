import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/iPadOS/components/appGrid.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'fileMenu/controlCentre.dart';
import 'package:mac_dt/system/folders.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/sizes.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'components/notification.dart';
import '../system/openApps.dart';
import '../theme/theme.dart';
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
    List<Widget> app = Provider.of<Apps>(context).getApps;
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
            Container(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  themeNotifier.isDark()
                      ? "assets/wallpapers/iPadOS_dark.jpg"
                      : "assets/wallpapers/iPadOS_light.jpg",
                  fit: BoxFit.cover,
                )),

            ///Apps Grid
            AppMenu(),

            ///Applications
            ...app,

            ///Notification
            Notifications(),

            //TODO State change of widgets under this will cause iFrame HTMLView to reload. Engine Fix required.
            /// Track the issue here: https://github.com/flutter/flutter/issues/80524

            ///docker bar
            Docker(),

            ///Control Centre
            Positioned(
              top: screenHeight(context, mulBy: 0.035),
              child: ControlCentre(),
            ),

            /// file menu
            FileMenu(),

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
