import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/sizes.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/system/folders.dart';
import 'package:provider/provider.dart';

class FileMenu extends StatefulWidget {

  FileMenu({
    Key key,
  }) : super(key: key);

  @override
  _FileMenuState createState() => _FileMenuState();
}

class _FileMenuState extends State<FileMenu> {
  var rand = new Random();
  int num;

  @override
  void initState() {
    num= rand.nextInt(20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Container(
        height: screenHeight(context, mulBy: 0.035),
        width: screenWidth(context,),
        padding: EdgeInsets.all(3),
        child: Row(
          children: [
            SizedBox(width: size.width*0.012,),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot){
                return FittedBox(fit: BoxFit.fitHeight,
                  child: Text(
                    "${DateFormat('hh:mm a E d LLL').format(DateTime.now())}",
                    style: TextStyle(fontFamily: 'HN',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),),);
              },),
            Spacer(),
            GestureDetector(
              onHorizontalDragStart: (yoyo){
                Provider.of<Folders>(context, listen: false).deSelectAll();
                Provider.of<OnOff>(context, listen: false).toggleCc();
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.chart_bar_fill, size: 15,),
                  SizedBox(width: size.width*0.014,),
                  Image.asset("assets/icons/wifi.png", height: 13.5,),
                  SizedBox(width: size.width*0.014,),
                  FittedBox(fit: BoxFit.fitHeight, child:Text("${num+60}% ", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, fontSize: 12.5, color: Colors.white),),),
                  Image.asset("assets/icons/battery.png", height: 12, ),
                  SizedBox(width: size.width*0.014,),
                ],
              ),
            ),
          ],
        )
    );
  }
}