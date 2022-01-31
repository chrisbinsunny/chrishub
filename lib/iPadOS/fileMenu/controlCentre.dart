import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/providers.dart';
import '../../theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../../system/componentsOnOff.dart';
import '../../sizes.dart';


//TODO slide down to reveal control centre
class ControlCentre extends StatefulWidget {
  const ControlCentre({Key key}) : super(key: key);

  @override
  _ControlCentreState createState() => _ControlCentreState();
}

class _ControlCentreState extends State<ControlCentre> {
  double brightness;
  double sound;

  @override
  void initState() {
    brightness = 95.98;
    sound= 35;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    brightness = Provider.of<DataBus>(context).getBrightness;

    BoxDecoration ccDecoration = BoxDecoration(
      color: Theme.of(context).backgroundColor,
      border: Border.all(color: Theme.of(context).cardColor, width: .55),
      borderRadius: BorderRadius.all(Radius.circular(10)),

      // backgroundBlendMode: BlendMode.luminosity,
    );
    CustomBoxShadow ccShadow = CustomBoxShadow(
        color: Theme.of(context).accentColor,
        spreadRadius: 0,
        blurRadius: 3,
        //offset: Offset(0, .5),
        blurStyle: BlurStyle.outer);
    var ccOpen = Provider.of<OnOff>(context).getCc;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool NSOn = Provider.of<DataBus>(
      context,
    ).getNS;
    return ccOpen
        ? InkWell(
      onTap: (){
        Provider.of<OnOff>(context, listen: false).toggleCc();
      },

          child: Container(
      color: Colors.white.withOpacity(0.04),
      padding: EdgeInsets.symmetric(
            vertical: screenHeight(context, mulBy: 0.007),
            horizontal: screenWidth(context, mulBy: 0.005)),
      height: screenHeight(context, ),
      width: screenWidth(context),
            child: new BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0, tileMode: TileMode.mirror),
      child: Align(
            alignment: Alignment.topRight,
            child: Container(
             height: screenHeight(context, mulBy: 0.55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(23)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 15.0, sigmaY: 15.0),
                          child:  Container(
                            margin: EdgeInsets.zero,
                            height: screenWidth(context, mulBy: 0.11),
                            width: screenWidth(context, mulBy: 0.11),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.2)
                                      ),
                                      height: screenHeight(context, mulBy: 0.059),
                                      width: screenWidth(context, mulBy: 0.039),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.airplane,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue
                                      ),
                                      height: screenHeight(context, mulBy: 0.059),
                                      width: screenWidth(context, mulBy: 0.039),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.antenna_radiowaves_left_right,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue
                                      ),
                                      height: screenHeight(context, mulBy: 0.059),
                                      width: screenWidth(context, mulBy: 0.039),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.wifi,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue
                                      ),
                                      height: screenHeight(context, mulBy: 0.059),
                                      width: screenWidth(context, mulBy: 0.039),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.bluetooth,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.0135),
                      ),
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(23)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 15.0, sigmaY: 15.0),
                          child:  Container(
                            margin: EdgeInsets.zero,
                            height: screenWidth(context, mulBy: 0.11),
                            width: screenWidth(context, mulBy: 0.11),
                            padding: EdgeInsets.only(
                                left: screenWidth(context, mulBy: 0.008),
                                right: screenWidth(context, mulBy: 0.008),
                                bottom: screenHeight(context, mulBy: 0.04),
                              top: screenHeight(context, mulBy: 0.01),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  child: Icon(
                                    CupertinoIcons.waveform_circle_fill,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.topRight,
                                ),
                                MBPText(
                                  text: "Not Playing",
                                  color: Colors.white.withOpacity(0.5),
                                  weight: FontWeight.w500,
                                  size: 17,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.backward_fill,
                                      size: 23,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    Icon(
                                      CupertinoIcons.play_arrow_solid,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    Icon(
                                      CupertinoIcons.forward_fill,
                                      size: 23,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context, mulBy: 0.015),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.11),
                        height: screenHeight(context, mulBy: 0.18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15.0, sigmaY: 15.0),
                                    child:  Container(
                                      margin: EdgeInsets.zero,
                                      height: screenHeight(context, mulBy: 0.081),
                                      width: screenWidth(context, mulBy: 0.0495),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white.withOpacity(0.8)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.lock_rotation,
                                          size: 35,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15.0, sigmaY: 15.0),
                                    child:  Container(
                                      margin: EdgeInsets.zero,
                                      height: screenHeight(context, mulBy: 0.081),
                                      width: screenWidth(context, mulBy: 0.0495),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: Colors.black.withOpacity(0.4)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.rectangle_on_rectangle,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context, mulBy: 0.01)
                              ),
                              height: screenHeight(context, mulBy: 0.081),
                              width: screenWidth(context, mulBy: 0.11),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  color: Colors.black.withOpacity(0.4)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.2)
                                    ),
                                    height: screenHeight(context, mulBy: 0.059),
                                    width: screenWidth(context, mulBy: 0.039),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        right: screenWidth(context, mulBy: 0.007)
                                    ),
                                    child: Center(
                                      child: Icon(
                                        CupertinoIcons.moon_fill,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  MBPText(
                                    text: "Focus",
                                    color: Colors.white.withOpacity(0.8),
                                    weight: FontWeight.w500,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.0135),
                      ),
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: screenHeight(context, mulBy: 0.18),
                              width: screenWidth(context, mulBy: 0.0495),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: SliderTheme(
                                  data: SliderTheme.of(context)
                                      .copyWith(
                                    trackHeight: screenWidth(context, mulBy: 0.0495),
                                    activeTrackColor: Colors.white,
                                    trackShape: RectangularSliderTrackShape(),
                                    inactiveTrackColor: Colors.black.withOpacity(0.4),
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                                    overlayShape: SliderComponentShape
                                        .noOverlay,
                                  ),
                                  child: Slider(
                                    value: brightness,
                                    min: 0,
                                    max: 95.98,
                                    onChanged: (val) {
                                      if (val < 6.7) val = 6.7;
                                      setState(() {
                                        brightness = val;
                                        Provider.of<DataBus>(context,
                                            listen: false)
                                            .setBrightness(brightness);
                                      });
                                    },

                                  ),
                                ),
                              ),
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: screenHeight(context, mulBy: 0.015)
                                ),
                                child: Icon(
                                  CupertinoIcons.brightness_solid,
                                  size: 30,
                                  color: Colors.black.withOpacity(0.55),
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.013),
                      ),
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: screenHeight(context, mulBy: 0.18),
                              width: screenWidth(context, mulBy: 0.0495),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: SliderTheme(
                                  data: SliderTheme.of(context)
                                      .copyWith(
                                    trackHeight: screenWidth(context, mulBy: 0.0495),
                                    activeTrackColor: Colors.white,
                                    trackShape: RectangularSliderTrackShape(),
                                    inactiveTrackColor: Colors.black.withOpacity(0.4),
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                                    overlayShape: SliderComponentShape
                                        .noOverlay,
                                  ),
                                  child: Slider(
                                    value: sound,
                                    min: 0,
                                    max: 95.98,
                                    onChanged: (val) {
                                      if (val < 6.7) val = 6.7;
                                      setState(() {
                                        sound = val;
                                      });
                                    },

                                  ),
                                ),
                              ),
                            ),
                            IgnorePointer(
                                ignoring: true,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight(context, mulBy: 0.015)
                                  ),
                                  child: Icon(
                                    CupertinoIcons.speaker_3_fill,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.55),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight(context, mulBy: 0.015),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 15.0, sigmaY: 15.0),
                          child:  Container(
                            margin: EdgeInsets.zero,
                            height: screenHeight(context, mulBy: 0.081),
                            width: screenWidth(context, mulBy: 0.0495),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.timer,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.0135),
                      ),
                      ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 15.0, sigmaY: 15.0),
                          child:  Container(
                            margin: EdgeInsets.zero,
                            height: screenHeight(context, mulBy: 0.081),
                            width: screenWidth(context, mulBy: 0.0495),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.black.withOpacity(0.4)
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.camera_fill,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.0135),
                      ),
                      InkWell(
                        mouseCursor: MouseCursor.defer,
                        onTap: () {
                          themeNotifier.isDark()
                              ? themeNotifier.setTheme(
                              ThemeNotifier
                                  .lightTheme)
                              : themeNotifier.setTheme(
                              ThemeNotifier
                                  .darkTheme);
                        },
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 15.0, sigmaY: 15.0),
                            child:  Container(
                              margin: EdgeInsets.zero,
                              height: screenHeight(context, mulBy: 0.081),
                              width: screenWidth(context, mulBy: 0.0495),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: themeNotifier.isDark() ? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.4)
                              ),
                              child: Center(
                                child:
                                Image.asset(
                                  "assets/icons/darkBlack.png",
                                  height:
                                  screenHeight(
                                      context,
                                      mulBy:
                                      0.035),
                                  color: themeNotifier.isDark() ? Colors.black:Colors.white,
                                  fit: BoxFit
                                      .fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, mulBy: 0.0135),
                      ),
                      InkWell(
                        mouseCursor: MouseCursor.defer,
                        onTap: () {
                          Provider.of<DataBus>(context, listen: false).toggleNS();
                        },
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 15.0, sigmaY: 15.0),
                            child:  Container(
                              margin: EdgeInsets.zero,
                              height: screenHeight(context, mulBy: 0.081),
                              width: screenWidth(context, mulBy: 0.0495),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                color: NSOn? Colors.orange.withOpacity(0.8):Colors.black.withOpacity(.4),
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.brightness,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
      ),
            ),
          ),
        )
        : Container();
  }
}
