import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/apps/launchpad.dart';
import 'package:mac_dt/components/wallpaper/wallpaper.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/system/folders/folders.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/system/rightClickMenu.dart';
import 'package:mac_dt/sizes.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import '../components/notification.dart';
import 'openApps.dart';
import '../components/dock.dart';
import '../fileMenu/fileMenu.dart';


class MacOS extends StatefulWidget {
  @override
  _MacOSState createState() => _MacOSState();
}

class _MacOSState extends State<MacOS> {



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool ccOpen = Provider.of<OnOff>(context).getCc;
    final dataBus = Provider.of<DataBus>(context, listen: true);
    List<Widget> apps = Provider.of<Apps>(context).getApps;
    List<Folder> folders = Provider.of<Folders>(context, listen: true).getFolders;
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
                    .setPos(details.globalPosition);
              },
              onTap: () {
                if (!mounted) return;
                tapFunctions(context);
              },
              child: Container(
                  height: size.height,
                  width: size.width,
                  child: ViewWallpaper(location: dataBus.getWallpaper.location,)),
            ),

            ///Desktop Items
           //...desktopItems,


            /// Folders
            ...folders,





            ///Applications
            ...apps,


            ///Right Click Context Menu
            RightClick(initPos: dataBus.getPos,),


            ///Folder Right Click Menu
            FolderRightClick(
              initPos: dataBus.getPos,
            ),

            /// file menu
            FileMenu(),



            //TODO State change of widgets under this will cause iFrame HTMLView to reload. Engine Fix required.
            /// Track the issue here: https://github.com/flutter/flutter/issues/80524

            ///LaunchPad
            LaunchPad(),

            ///Notification
            Notifications(),

            ///docker bar
            Docker(),

            ///Click to dismiss Control Centre
            Visibility(
              visible: ccOpen,
                  child: InkWell(
                      onTap: () {
                        Provider.of<OnOff>(context, listen: false).offCc();

                      },
              mouseCursor: SystemMouseCursors.basic,
                      child: Container(
                        height: screenHeight(context),
                        width: screenWidth(context),
                      ),
                    ),
            ),

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
                  color: Colors.orange.withOpacity(dataBus.getNS ? 0.2 : 0),
                ),
              ),
            ),

            ///Control Brightness
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 1 - (dataBus.getBrightness! / 95.98),
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

