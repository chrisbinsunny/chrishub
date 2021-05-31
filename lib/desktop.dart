import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/fileMenu/controlCentre.dart';
import 'package:mac_dt/sizes.dart';
import 'package:provider/provider.dart';

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
  double _horizontalPos = 0.0;
  double _verticalPos = 0.0;

  _buildDraggable() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 100),
        color: Colors.green,
        child: Builder(
          builder: (context) {
            final handle = Container(
              width: 150.0,
              height: 200.0,
              color: Colors.red,
              child: Column(
                children: [
                  GestureDetector(
                    // onPanEnd: (offset){
                    //   debugPrint("Container Pos= ${offset}");
                    // },

                    onPanUpdate: (details) {
                      debugPrint("Container= ${details.globalPosition},${details.localPosition}");
                      _verticalPos =
                          (_verticalPos + details.delta.dy / (context.size.height))
                              .clamp(.0, 1);
                      _horizontalPos =
                          (_horizontalPos + details.delta.dx / (context.size.width))
                              .clamp(.0, 1);

                     posValueListener.value = [_horizontalPos, _verticalPos];
                      debugPrint("Container value= ${posValueListener.value}");
                      //posValueListener.value= [details.globalPosition.dx,details.globalPosition.dy];
                    },
                    child: Container(
                      color: Colors.black87,
                      width: 110.0,
                      height: 80.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 110.0,
                    height: 90.0,
                    child: Container(
                      color: Colors.blue,
                    ),
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ],
              ),
            );

            return ValueListenableBuilder<List<double>>(
              valueListenable: posValueListener,
              builder:
                  (BuildContext context, List<double> value, Widget child) {
                return Align(
                  alignment: Alignment(value[0] * 2 - 1, value[1] * 2 - 1),
                  child: handle,
                );
              },
            );
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            //wallpaper
            Container(
                height:size.height,
                width: size.width,
                child: Image.asset(themeNotifier.isDark()?"assets/wallpapers/bigsur_dark.jpg":"assets/wallpapers/bigsur_light.jpg",  fit: BoxFit.cover,)),
            //file menu
            FileMenu(),
            //docker bar
            Docker(),
            //FinderWindow
            DragBox(Offset(screenWidth(context,mulBy:0.2),screenHeight(context,mulBy: 0.18)), 'Box One'),
            //Control Centre
            //_buildDraggable(),
            MoveableStackItem(),
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



