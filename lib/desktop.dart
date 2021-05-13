import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/sizes.dart';

import 'components/docker.dart';
import 'components/finderWindow.dart';
import 'fileMenu.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool finderOpen = true;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            //wallpaper
            Container(
                height:size.height,
                width: size.width,
                child: Image.asset("assets/wallpapers/bigsur_light.jpg",  fit: BoxFit.cover,)),
            //file menu
            FileMenu(),
            //finder bar
            Docker(),
            //GamePlay(),
            DragBox(Offset(screenWidth(context,mulBy:0.2),screenHeight(context,mulBy: 0.18)), 'Box One'),
          ],
        ),
      ),
    );
  }
}



