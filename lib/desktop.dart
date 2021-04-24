import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var rand = new Random();
    DateTime now = DateTime.now();
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
            ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
                child: new Container(
                  height: size.height*0.035,
                  width: size.width,
                  padding: EdgeInsets.all(3),
                  decoration: new BoxDecoration(
                      color: Colors.blue.withOpacity(0.6),
                      border:  Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.5,
                        ),
                  ),),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: size.width*0.012,),
                          Image.asset("assets/icons/apple_file.png"),
                          SizedBox(width: size.width*0.013,),
                          Text("Finder", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w800),),
                          SizedBox(width: size.width*0.014,),
                          Text("File", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                          Text("Edit", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                          Text("View", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                          Text("Go", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                          Text("Window", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                          Text("Help", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),


                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text("${rand.nextInt(20)+60}% ", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600, fontSize: 12.5),),
                          Image.asset("assets/icons/battery.png", height: 12,),
                          SizedBox(width: size.width*0.014,),
                          Image.asset("assets/icons/wifi.png", height: 13.5,),
                          SizedBox(width: size.width*0.014,),
                          Image.asset("assets/icons/spotlight.png", height: 14.5),
                          SizedBox(width: size.width*0.014,),
                          Image.asset("assets/icons/cc.png", height: 16,),
                          SizedBox(width: size.width*0.014,),
                          Image.asset("assets/icons/siri.png", height: 15),
                          SizedBox(width: size.width*0.014,),
                          Text("${DateFormat('E d LLL h:m a').format(now)}", style: TextStyle(fontFamily: 'SF', fontWeight: FontWeight.w600),),
                          SizedBox(width: size.width*0.014,),
                        ],
                      ),
                    ],
                  )
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
