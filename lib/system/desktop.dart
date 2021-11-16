import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/apps/launchpad.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/system/folders.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/system/rightClickMenu.dart';
import 'package:mac_dt/sizes.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:flutter/rendering.dart';
import '../components/notifiaction.dart';
import 'openApps.dart';
import '../theme/theme.dart';
import '../components/dock.dart';
import '../fileMenu/fileMenu.dart';

class MacOS extends StatefulWidget {
  @override
  _MacOSState createState() => _MacOSState();
}

class _MacOSState extends State<MacOS> {
  bool finderOpen = true;



  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.aspectRatio);
    print(screenWidth(context));
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
                        ? "assets/wallpapers/bigsur_dark.jpg"
                        : "assets/wallpapers/bigsur_light.jpg",
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

            ///Click to dismiss Control Centre
            ccOpen
                ? InkWell(
                    onTap: () {
                      Provider.of<OnOff>(context, listen: false).offCc();
                    },
                    child: Container(
                      height: screenHeight(context),
                      width: screenWidth(context),
                    ),
                  )
                : Container(),

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

class Unfocuser extends StatelessWidget {
  const Unfocuser({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (e) {
        final rb = context.findRenderObject() as RenderBox;
        final result = BoxHitTestResult();
        rb.hitTest(result, position: e.position);

        for (final e in result.path) {
          if (e.target is RenderEditable) {
            return;
          }
        }

        final primaryFocus = FocusManager.instance.primaryFocus;

        if (primaryFocus.context.widget is EditableText) {
          primaryFocus.unfocus();
        }
      },
      child: child,
    );
  }
}
