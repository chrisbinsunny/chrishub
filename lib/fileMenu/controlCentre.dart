import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_dt/providers.dart';
import '../theme/theme.dart';
import 'package:mac_dt/widgets.dart';
import 'package:provider/provider.dart';

import '../system/componentsOnOff.dart';
import '../sizes.dart';

class ControlCentre extends StatefulWidget {
  const ControlCentre({Key? key}) : super(key: key);

  @override
  _ControlCentreState createState() => _ControlCentreState();
}

class _ControlCentreState extends State<ControlCentre> {
  double? brightness;
  late double sound;

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
        ? Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 15.0,
                      sigmaY: 15.0,
                    ),
                    child: Container(
                      height: screenHeight(context, mulBy: 0.45) + 1,
                      width: screenWidth(context, mulBy: 0.2) + 1,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(
                            color: Theme.of(context).splashColor, width: 1.1),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, mulBy: 0.007),
                            vertical: screenHeight(context, mulBy: 0.014)),
                        margin: EdgeInsets.zero,
                        height: screenHeight(context, mulBy: 0.45),
                        width: screenWidth(context, mulBy: 0.2),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          border: Border.all(
                              color: Theme.of(context).cardColor, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [ccShadow],
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 15.0, sigmaY: 15.0),
                                      child: BrdrContainer(
                                        height: 0.17,
                                        width: 0.09,
                                        child: Container(
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth(context,
                                                  mulBy: 0.013),
                                              vertical: screenHeight(context,
                                                  mulBy: 0.025)),
                                          height: screenHeight(context,
                                              mulBy: 0.17),
                                          width:
                                              screenWidth(context, mulBy: 0.09),
                                          decoration: ccDecoration,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenHeight(context, mulBy: 0.17),
                                  width: screenWidth(context, mulBy: 0.09),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [ccShadow],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15.0, sigmaY: 15.0),
                                            child: BrdrContainer(
                                              height: 0.08,
                                              width: 0.09,
                                              child: InkWell(
                                                mouseCursor: MouseCursor.defer,
                                                onTap: () {
                                                  Provider.of<DataBus>(context, listen: false).toggleNS();
                                                },
                                                child: Container(
                                                  height: screenHeight(context,
                                                      mulBy: 0.08),
                                                  width: screenWidth(context,
                                                      mulBy: 0.09),
                                                  decoration: ccDecoration,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                        child: BackdropFilter(
                                                          filter:
                                                          ImageFilter.blur(
                                                              sigmaX: 15.0,
                                                              sigmaY: 15.0),
                                                          child: Container(
                                                            height:
                                                            screenHeight(
                                                                context,
                                                                mulBy:
                                                                0.0456),
                                                            width: screenWidth(
                                                                context,
                                                                mulBy: 0.0219),
                                                            decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: NSOn? Colors.orange.withOpacity(0.8):Colors.black.withOpacity(.13),
                                                            ),
                                                            child: Center(
                                                              child:
                                                              Icon(
                                                                CupertinoIcons.brightness,
                                                                color: Colors.white.withOpacity(0.7),
                                                                size: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: MBPText(
                                                            overflow:
                                                            TextOverflow.visible,
                                                            maxLines: 2,
                                                            text:
                                                            "Night Shift\n${NSOn ? "On" : "Off"}",
                                                            color: Theme.of(context)
                                                                .cardColor
                                                                .withOpacity(1),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [ccShadow],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15.0, sigmaY: 15.0),
                                            child: BrdrContainer(
                                              height: 0.08,
                                              width: 0.09,
                                              child: InkWell(
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
                                                child: Container(
                                                  height: screenHeight(context,
                                                      mulBy: 0.08),
                                                  width: screenWidth(context,
                                                      mulBy: 0.09),
                                                  decoration: ccDecoration,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 15.0,
                                                                  sigmaY: 15.0),
                                                          child: Container(
                                                            height:
                                                                screenHeight(
                                                                    context,
                                                                    mulBy:
                                                                        0.0456),
                                                            width: screenWidth(
                                                                context,
                                                                mulBy: 0.0219),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .highlightColor,
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
                                                                "assets/icons/darkBlack.png",
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        mulBy:
                                                                            0.032),
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: MBPText(
                                                        overflow:
                                                            TextOverflow.visible,
                                                        maxLines: 2,
                                                        text:
                                                            "Dark Mode\n${themeNotifier.isDark() ? "On" : "Off"}",
                                                        color: Theme.of(context)
                                                            .cardColor
                                                            .withOpacity(1),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [ccShadow],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 15.0, sigmaY: 15.0),
                                  child: BrdrContainer(
                                    height: 0.08,
                                    width: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              mulBy: 0.005),
                                          vertical: screenHeight(context,
                                              mulBy: 0.005)),
                                      height:
                                          screenHeight(context, mulBy: 0.08),
                                      width: screenWidth(
                                        context,
                                      ),
                                      decoration: ccDecoration,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MBPText(
                                            overflow: TextOverflow.clip,
                                            text: "Display",
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(1),
                                          ),
                                          Stack(
                                            clipBehavior: Clip.antiAlias,
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  trackHeight: 15,
                                                  activeTrackColor: Colors.white,
                                                  thumbColor: Colors.white,
                                                  minThumbSeparation: 20,
                                                  trackShape: SliderTrackShape(),
                                                  inactiveTrackColor: Colors.white
                                                      .withOpacity(0.25),
                                                  thumbShape: RoundSliderThumbShape(
                                                      enabledThumbRadius: 8.4,
                                                      elevation: 10,
                                                    pressedElevation: 20
                                                  ),
                                                  overlayShape: SliderComponentShape
                                                      .noOverlay,
                                                ),
                                                child: Slider(
                                                  value: brightness!,
                                                  min: 0,
                                                  max: 100,
                                                  onChanged: (val) {
                                                    if (val > 95.98)
                                                      val = 95.98;
                                                    else if (val < 6.7) val = 6.7;
                                                    setState(() {
                                                      brightness = val;
                                                      Provider.of<DataBus>(context,
                                                              listen: false)
                                                          .setBrightness(brightness);
                                                    });
                                                  },
                                                ),
                                              ),
                                              IgnorePointer(
                                                ignoring: true,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 2,),
                                                    Image.asset(
                                                      "assets/icons/brightness.png",
                                                      height: 15,
                                                      color: Colors.black.withOpacity(0.55),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          //CCSlider(height: 16, width: screenWidth(context),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                boxShadow: [ccShadow],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 15.0, sigmaY: 15.0),
                                  child: BrdrContainer(
                                    height: 0.08,
                                    width: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              mulBy: 0.005),
                                          vertical: screenHeight(context,
                                              mulBy: 0.005)),
                                      height:
                                      screenHeight(context, mulBy: 0.08),
                                      width: screenWidth(
                                        context,
                                      ),
                                      decoration: ccDecoration,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          MBPText(
                                            overflow: TextOverflow.clip,
                                            text: "Sound",
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(1),
                                          ),
                                          Stack(
                                            clipBehavior: Clip.antiAlias,
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  trackHeight: 15,
                                                  activeTrackColor: Colors.white,
                                                  thumbColor: Colors.white,
                                                  minThumbSeparation: 20,
                                                  trackShape: SliderTrackShape(),
                                                  inactiveTrackColor: Colors.white
                                                      .withOpacity(0.25),
                                                  thumbShape: RoundSliderThumbShape(
                                                      enabledThumbRadius: 8.4,
                                                      elevation: 10,
                                                      pressedElevation: 20
                                                  ),
                                                  overlayShape: SliderComponentShape
                                                      .noOverlay,
                                                ),
                                                child: Slider(
                                                  value: sound,
                                                  min: 0,
                                                  max: 100,
                                                  onChanged: (val) {
                                                    if (val > 95.98)
                                                      val = 95.98;
                                                    else if (val < 6.7) val = 6.7;
                                                    setState(() {
                                                      sound = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                              IgnorePointer(
                                                ignoring: true,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 4,),
                                                    Image.asset(
                                                      "assets/icons/sound.png",
                                                      height: 13,
                                                      color: Colors.black.withOpacity(0.55),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),

                                          //CCSlider(height: 16, width: screenWidth(context),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                boxShadow: [ccShadow],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 15.0, sigmaY: 15.0),
                                  child: BrdrContainer(
                                    height: 0.075,
                                    width: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              mulBy: 0.005),
                                          vertical: screenHeight(context,
                                              mulBy: 0.005)),
                                      height:
                                      screenHeight(context, mulBy: 0.075),
                                      width: screenWidth(
                                        context,
                                      ),
                                      decoration: ccDecoration,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                         Container(
                                           height: screenHeight(context, mulBy: 0.059),
                                           width: screenWidth(context, mulBy: 0.028),
                                           decoration: BoxDecoration(
                                             color: Theme.of(context)
                                                 .bottomAppBarColor,
                                             borderRadius: BorderRadius.circular(5)
                                           ),
                                           margin: EdgeInsets.only(right: screenWidth(context, mulBy: 0.005)),
                                           child: Center(
                                             child: Image.asset(
                                               "assets/apps/itunes.png",
                                               height:
                                               screenHeight(
                                                   context,
                                                   mulBy:
                                                   0.035),
                                               fit: BoxFit
                                                   .fitHeight,
                                             ),
                                           ),
                                         ),
                                          MBPText(
                                            overflow: TextOverflow.clip,
                                            text: "Music",
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(1),
                                          ),
                                          Spacer(),
                                          Icon(
                                            CupertinoIcons.play_arrow_solid,
                                          size: 17,
                                            color: Theme.of(context)
                                                .bottomAppBarColor.withOpacity(0.5),
                                          ),
                                          SizedBox(
                                            width: screenWidth(context, mulBy: 0.005),
                                          ),
                                          Icon(
                                            CupertinoIcons.forward_fill,
                                            size: 16,
                                            color: Theme.of(context)
                                                .bottomAppBarColor.withOpacity(0.3),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}

class BrdrContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  final double width;
  const BrdrContainer({this.height = 1, this.width = 1, this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, mulBy: height) + 1,
      width: screenWidth(context, mulBy: width) + 1,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(0.00),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).shadowColor, width: 1),
      ),
      child: child,
    );
  }
}

class SliderTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
