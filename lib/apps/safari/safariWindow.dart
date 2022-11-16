import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

//TODO: BUG Found>> After opening youtube all searches redirects to youtube.

class Safari extends StatefulWidget {
  final Offset? initPos;
  const Safari({this.initPos, Key? key}) : super(key: key);

  @override
  _SafariState createState() => _SafariState();
}

class _SafariState extends State<Safari> {
  Offset? position = Offset(0.0, 0.0);
  String selected = "Applications";
  TextEditingController urlController = new TextEditingController();
  late bool safariFS;
  late bool safariPan;
  String url = "";
  bool isDoc = false;
  final html.IFrameElement _iframeElementURL = html.IFrameElement();
  final html.IFrameElement _iframeElementDOC = html.IFrameElement();

  void handleURL(
    String text,
  ) {
    isDoc = false;
    text = text.trim();
    if (text.length == 0) return;



    if (text.indexOf("http://") != 0 && text.indexOf("https://") != 0) {
      url = "https://" + text + "/";
    } else {
      url = text;
    }

    if (url.contains("pornhub")||url.contains("porn")||url.contains("xxx")) {
      url = "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1&enablejsapi=1";
    }

    if (url.contains("google")) {
      url = "https://www.google.com/webhp?igu=1";
    }

    setState(() {
      url = Uri.encodeFull(url);
      urlController.text = url.substring(8, url.indexOf("/", 8));
      _iframeElementURL.src = url;
      debugPrint(_iframeElementURL.innerHtml.toString());
    });
  }

  void handleDOC(
    String text,
  ) {
    text = text.trim();
    if (text.length == 0) return;

    setState(() {
      isDoc = true;
      url = text;
      urlController.text = url.substring(8, url.indexOf("/", 8));

      _iframeElementDOC.srcdoc = url;
    });
  }

  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    _iframeElementURL.src = 'https://www.google.com/webhp?igu=1';
    _iframeElementURL.style.border = 'none';
    _iframeElementURL.allow = "autoplay";
    _iframeElementURL.allowFullscreen = true;
    ui.platformViewRegistry.registerViewFactory(
      'urlIframe',
      (int viewId) => _iframeElementURL,
    );

    ui.platformViewRegistry.registerViewFactory(
      'docIframe',
      (int viewId) => _iframeElementDOC,
    );
  }

  @override
  Widget build(BuildContext context) {
    var safariOpen = Provider.of<OnOff>(context).getSafari;
    safariFS = Provider.of<OnOff>(context).getSafariFS;
    safariPan = Provider.of<OnOff>(context).getSafariPan;
    return safariOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: safariPan ? 0 : 200),
            top: safariFS ? 25 : position!.dy,
            left: safariFS ? 0 : position!.dx,
            child: safariWindow(context),
          )
        : Container();
  }

  AnimatedContainer safariWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    log(screenHeight(context,
        mulBy: 0.08).toString());
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: safariFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.57),
      height: safariFS
          ?screenHeight(context, mulBy: 0.975)
          : screenHeight(context, mulBy: 0.7),
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
                    height: safariFS
                        ? screenHeight(context, mulBy: 0.059)
                        : screenHeight(context, mulBy: 0.06),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                  ),
                  GestureDetector(
                    onPanUpdate: (tapInfo) {
                      if (!safariFS) {
                        setState(() {
                          position = Offset(position!.dx + tapInfo.delta.dx,
                              position!.dy + tapInfo.delta.dy);
                        });
                      }
                    },
                    onPanStart: (details) {
                      Provider.of<OnOff>(context, listen: false).onSafariPan();
                    },
                    onPanEnd: (details) {
                      Provider.of<OnOff>(context, listen: false).offSafariPan();
                    },
                    onDoubleTap: () {
                      Provider.of<OnOff>(context, listen: false).toggleSafariFS();
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      width: safariFS
                          ? screenWidth(context, mulBy: 0.95)
                          : screenWidth(context, mulBy: 0.7),
                      height: safariFS
                          ? screenHeight(context, mulBy: 0.059)
                          : screenHeight(context, mulBy: 0.06),
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
                                Provider.of<OnOff>(context, listen: false)
                                    .offSafariFS();
                                Provider.of<Apps>(context, listen: false).closeApp("safari");
                                Provider.of<OnOff>(context, listen: false).toggleSafari();
                                url = "";
                                urlController.text = "";
                              },
                            ),
                            SizedBox(
                              width: screenWidth(context, mulBy: 0.005),
                            ),
                            InkWell(
                              onTap: (){
                                Provider.of<OnOff>(context, listen: false).toggleSafari();
                                Provider.of<OnOff>(context, listen: false).offSafariFS();
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
                                    .toggleSafariFS();
                              },
                            )
                          ],
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        Center(
                          child: Container(
                            height: screenHeight(context, mulBy: 0.033),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              color: Theme.of(context).cardColor.withOpacity(0.5),
                              icon: Icon(Icons.home_outlined, size: 22,),
                                onPressed: () {
                                  setState(() {
                                    url = "";
                                    urlController.text = "";
                                  });
                                },
                               ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 300,
                          height: screenHeight(context, mulBy: 0.03), //0.038
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: TextField(

                                controller: urlController,
                                //textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.center,
                                cursorColor:
                                    Theme.of(context).cardColor.withOpacity(0.55),
                                onSubmitted: (text) => handleURL(text),
                                style: TextStyle(
                                  height: 2,
                                  color: Theme.of(context).cardColor.withOpacity(1),
                                  fontFamily: "HN",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Search or enter website name", //TODO
                                  isCollapsed: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5.0, 00.0, 5.0, 3.0),
                                  hintStyle: TextStyle(
                                    height: 2,
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.4),
                                    fontFamily: "HN",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 6,
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
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: screenWidth(context, mulBy: 0.013),
                      //     vertical: screenHeight(context, mulBy: 0.025)),
                      height: screenHeight(context, mulBy: 0.14),
                      width: screenWidth(
                        context,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor,
                      ),
                      child: (url == "")
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight(context, mulBy: 0.08),
                                  horizontal: screenWidth(context, mulBy: 0.12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MBPText(
                                    text: "Favourites",
                                    color:
                                        Theme.of(context).cardColor.withOpacity(1),
                                    size: 22,
                                    weight: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .fontWeight,
                                  ),
                                  SizedBox(
                                    height: screenHeight(context, mulBy: 0.02),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          html.window.open(
                                            'https://www.apple.com',
                                            'new tab',
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),

                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/apple.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "Apple",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          handleURL(
                                              "https://www.google.com/webhp?igu=1");
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/google.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "Google",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          handleURL(
                                              "https://www.youtube.com/embed/GEZhD3J89ZE?start=4207&autoplay=1&enablejsapi=1");
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/youtube.jpg",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "Youtube",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          handleDOC(
                                            '<a class="twitter-timeline" href="https://twitter.com/chrisbinsunny?ref_src=twsrc%5Etfw">Tweets by chrisbinsunny</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/twitter.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "Twitter",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          html.window.open(
                                              "https://github.com/chrisbinsunny",
                                              "new_tab");
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/github.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "GitHub",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          html.window.open(
                                              "https://www.instagram.com/binary.ghost",
                                              "new_tab");
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Image.asset(
                                                  "assets/caches/insta.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  mulBy: 0.01),
                                            ),
                                            MBPText(
                                              text: "Instagram",
                                              size: 10,
                                              color: Theme.of(context)
                                                  .cardColor
                                                  .withOpacity(0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : ((!isDoc)
                              ? HtmlElementView(
                                  viewType: 'urlIframe',
                                )
                              : HtmlElementView(
                                  viewType: 'docIframe',
                                )),
                    ),
                  ),
                ),
              ),
            ],
          ),


    Visibility(
      visible: topApp != "Safari",
      child: InkWell(
        onTap: (){
          Provider.of<Apps>(context, listen: false)
              .bringToTop(ObjectKey("safari"));
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
