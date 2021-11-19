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
    brightness = 100;
    sound= 35;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(screenHeight(context, mulBy: 0.55));
    print(screenWidth(context, mulBy: 0.24));
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
        ? new BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),

      child: Align(
        alignment: Alignment.topRight,
        child: Container(
         // width: screenWidth(context, mulBy: 0.24),
         height: screenHeight(context, mulBy: 0.55),
         color: Colors.green,
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
                                max: 100,
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
                          child: Image.asset(
                            "assets/icons/brightness.png",
                            height: 15,
                            color: Colors.black.withOpacity(0.55),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context, mulBy: 0.0135),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.01)
                    ),
                    height: screenHeight(context, mulBy: 0.18),
                    width: screenWidth(context, mulBy: 0.0495),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15)),
                        color: Colors.black.withOpacity(0.4)
                    ),
                    child: Container(
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
                    ),
                  ),
                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius:
              //     BorderRadius.all(Radius.circular(10)),
              //     boxShadow: [ccShadow],
              //   ),
              //   child: ClipRRect(
              //     borderRadius:
              //     BorderRadius.all(Radius.circular(10)),
              //     child: BackdropFilter(
              //       filter: ImageFilter.blur(
              //           sigmaX: 15.0, sigmaY: 15.0),
              //       child: BrdrContainer(
              //         height: 0.08,
              //         width: 1,
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: screenWidth(context,
              //                   mulBy: 0.005),
              //               vertical: screenHeight(context,
              //                   mulBy: 0.005)),
              //           height:
              //           screenHeight(context, mulBy: 0.08),
              //           width: screenWidth(
              //             context,
              //           ),
              //           decoration: ccDecoration,
              //           child: Column(
              //             mainAxisAlignment:
              //             MainAxisAlignment.spaceEvenly,
              //             crossAxisAlignment:
              //             CrossAxisAlignment.start,
              //             children: [
              //               MBPText(
              //                 overflow: TextOverflow.clip,
              //                 text: "Sound",
              //                 color: Theme.of(context)
              //                     .cardColor
              //                     .withOpacity(1),
              //               ),
              //               Stack(
              //                 clipBehavior: Clip.antiAlias,
              //                 alignment: Alignment.centerLeft,
              //                 children: [
              //                   SliderTheme(
              //                     data: SliderTheme.of(context)
              //                         .copyWith(
              //                       trackHeight: 15,
              //                       activeTrackColor: Colors.white,
              //                       thumbColor: Colors.white,
              //                       minThumbSeparation: 20,
              //                       trackShape: SliderTrackShape(),
              //                       inactiveTrackColor: Colors.white
              //                           .withOpacity(0.25),
              //                       thumbShape: RoundSliderThumbShape(
              //                           enabledThumbRadius: 8.4,
              //                           elevation: 10,
              //                           pressedElevation: 20
              //                       ),
              //                       overlayShape: SliderComponentShape
              //                           .noOverlay,
              //                     ),
              //                     child: Slider(
              //                       value: sound,
              //                       min: 0,
              //                       max: 100,
              //                       onChanged: (val) {
              //                         if (val > 95.98)
              //                           val = 95.98;
              //                         else if (val < 6.7) val = 6.7;
              //                         setState(() {
              //                           sound = val;
              //                         });
              //                       },
              //                     ),
              //                   ),
              //                   IgnorePointer(
              //                     ignoring: true,
              //                     child: Row(
              //                       children: [
              //                         SizedBox(width: 4,),
              //                         Image.asset(
              //                           "assets/icons/sound.png",
              //                           height: 13,
              //                           color: Colors.black.withOpacity(0.55),
              //                         ),
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //
              //               //CCSlider(height: 16, width: screenWidth(context),),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
        )
        : Container();
  }
}

class BrdrContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  const BrdrContainer({this.height = 1, this.width = 1, this.child, Key key})
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
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
