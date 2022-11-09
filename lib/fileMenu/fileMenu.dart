import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/system/openApps.dart';
import 'package:mac_dt/sizes.dart';
import 'package:provider/provider.dart';

import '../system/componentsOnOff.dart';
import '../system/folders.dart';

class FileMenu extends StatefulWidget {

  FileMenu({
    Key? key,
  }) : super(key: key);

  @override
  _FileMenuState createState() => _FileMenuState();
}

class _FileMenuState extends State<FileMenu> {
  var rand = new Random();
  late int num;

  @override
  void initState() {
    num= rand.nextInt(20);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    String topApp= Provider.of<Apps>(context).getTop;
    return ClipRect(
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
        child: new Container(
            height: screenHeight(context, mulBy: 0.035),
            width: screenWidth(context,),
            padding: EdgeInsets.all(3),
            decoration: new BoxDecoration(
              color: Theme.of(context).canvasColor,
              border:  Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.0),
                  width: 0.5,
                ),
              ),),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(width: size.width*0.012,),
                    Image.asset("assets/icons/apple_file.png",),
                    SizedBox(width: size.width*0.013,),
                    //TODO
                    FittedBox(fit: BoxFit.fitHeight, child: Text(topApp, style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w600, color: Colors.white),)),
                    SizedBox(width: size.width*0.014,),
          FittedBox(fit: BoxFit.fitHeight, child:Text("File", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),
                    SizedBox(width: size.width*0.014,),
            FittedBox(fit: BoxFit.fitHeight, child:Text("Edit", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),
                    SizedBox(width: size.width*0.014,),
    FittedBox(fit: BoxFit.fitHeight, child:Text("View", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),
                    SizedBox(width: size.width*0.014,),
    FittedBox(fit: BoxFit.fitHeight, child: Text("Go", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),
                    SizedBox(width: size.width*0.014,),
    FittedBox(fit: BoxFit.fitHeight, child: Text("Window", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),
                    SizedBox(width: size.width*0.014,),
    FittedBox(fit: BoxFit.fitHeight, child: Text("Help", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, color: Colors.white),),),


                  ],
                ),
                Spacer(),
                Row(
                  children: [
                  FittedBox(fit: BoxFit.fitHeight, child:Text("${num+60}% ", style: TextStyle(fontFamily: 'HN', fontWeight: FontWeight.w400, fontSize: 12.5, color: Colors.white),),),
                    Image.asset("assets/icons/battery.png", height: 12, ),
                    SizedBox(width: size.width*0.014,),
                    Image.asset("assets/icons/wifi.png", height: 13.5,),
                    SizedBox(width: size.width*0.014,),
                    Image.asset("assets/icons/spotlight.png", height: 14.5,),
                    SizedBox(width: size.width*0.014,),
                    InkWell(child: Image.asset("assets/icons/cc.png", height: 16,filterQuality: FilterQuality.low,),
                    onTap: (){
                      Provider.of<Folders>(context, listen: false).deSelectAll();
                      Provider.of<OnOff>(context, listen: false).toggleCc();
                    },
                    ),
                    SizedBox(width: size.width*0.014,),
                    Image.asset("assets/icons/siri.png", height: 15),
                    SizedBox(width: size.width*0.014,),
                    // FittedBox(fit: BoxFit.fitHeight,
                    //   child: Text(
                    //     "${DateFormat('E d LLL hh:mm a').format(DateTime.now())}",
                    //     style: TextStyle(fontFamily: 'HN',
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white),),),
                    StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot){
                      return FittedBox(fit: BoxFit.fitHeight,
                        child: Text(
                          "${DateFormat('E d LLL hh:mm a').format(DateTime.now())}",
                          style: TextStyle(fontFamily: 'HN',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),),);
                    },),
                    SizedBox(width: size.width*0.014,),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}