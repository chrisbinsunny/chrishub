import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../system/openApps.dart';
import '../sizes.dart';
import '../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class VSCode extends StatefulWidget {
  final Offset? initPos;
  const VSCode({this.initPos, Key? key}) : super(key: key);

  @override
  _VSCodeState createState() => _VSCodeState();
}

class _VSCodeState extends State<VSCode> {
  Offset? position = Offset(0.0, 0.0);
  late bool vsFS;
  late bool vsPan;
  final html.IFrameElement _iframeElementURL = html.IFrameElement();

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    _iframeElementURL.src = 'https://github1s.com/chrisbinsunny/chrisbinsunny.github.io/blob/master/js/jquery.animatedheadline.js';
    _iframeElementURL.style.border = 'none';
    _iframeElementURL.allow = "autoplay";
    _iframeElementURL.allowFullscreen = true;
    ui.platformViewRegistry.registerViewFactory(
      'vsIframe',
          (int viewId) => _iframeElementURL,
    );

  }

  @override
  Widget build(BuildContext context) {
    var vsOpen = Provider.of<OnOff>(context).getVS;
    vsFS = Provider.of<OnOff>(context).getVSFS;
    vsPan = Provider.of<OnOff>(context).getVSPan;
    return vsOpen
        ? AnimatedPositioned(
      duration: Duration(milliseconds: vsPan ? 0 : 200),
      top: vsFS ? 25 : position!.dy,
      left: vsFS ? 0 : position!.dx,
      child: vsWindow(context),
    )
        : Container();
  }

  AnimatedContainer vsWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: vsFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.55),
      height: vsFS
          ? screenHeight(context, mulBy: 0.975):screenHeight(context, mulBy: 0.7),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: vsFS
                        ? screenHeight(context, mulBy: 0.056)
                        : screenHeight(context, mulBy: 0.053),
                    decoration: BoxDecoration(
                        color: Color(0xff252526),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                  ),
                  GestureDetector(
                    onPanUpdate: (tapInfo) {
                      if (!vsFS) {
                        setState(() {
                          position = Offset(position!.dx + tapInfo.delta.dx,
                              position!.dy + tapInfo.delta.dy);
                        });
                      }
                    },
                    onPanStart: (details) {
                      Provider.of<OnOff>(context, listen: false).onVSPan();
                    },
                    onPanEnd: (details) {
                      Provider.of<OnOff>(context, listen: false).offVSPan();
                    },
                    onDoubleTap: () {
                      Provider.of<OnOff>(context, listen: false).toggleVSFS();
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      width: vsFS
                          ? screenWidth(context, mulBy: 0.95)
                          : screenWidth(context, mulBy: 0.7),
                      height: vsFS
                          ? screenHeight(context, mulBy: 0.056)
                          : screenHeight(context, mulBy: 0.053),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 0.8))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.013),
                        vertical: screenHeight(context, mulBy: 0.01)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Provider.of<Apps>(context, listen: false).closeApp("vscode");
                                Provider.of<OnOff>(context, listen: false)
                                    .offVSFS();
                                Provider.of<OnOff>(context, listen: false).toggleVS();

                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: (){
                                Provider.of<OnOff>(context, listen: false).toggleVS();
                                Provider.of<OnOff>(context, listen: false).offVSFS();
                              },
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              child: Container(
                                height: 11.5,
                                width: 11.5,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Provider.of<OnOff>(context, listen: false)
                                    .toggleVSFS();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                    child: Container(
                      height: screenHeight(context, mulBy: 0.14),
                      width: screenWidth(
                        context,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1e1e1e).withOpacity(0.9),
                      ),
                      child: HtmlElementView(
                        viewType: 'vsIframe',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


    Visibility(
      visible: topApp != "VS Code",
      child: InkWell(
        onTap: (){
          Provider.of<Apps>(context, listen: false)
              .bringToTop(ObjectKey("vscode"));
        },
        child: Container(
          width: screenWidth(context,),
          height: screenHeight(context,),
          color: Colors.transparent,
        ),
      ),
    ),
        ],
      ),
    );
  }
}
