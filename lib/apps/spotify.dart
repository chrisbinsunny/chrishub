import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../sizes.dart';
import '../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class Spotify extends StatefulWidget {
  final Offset initPos;
  const Spotify({this.initPos, Key key}) : super(key: key);

  @override
  _SpotifyState createState() => _SpotifyState();
}

class _SpotifyState extends State<Spotify> {
  Offset position = Offset(0.0, 0.0);
  bool spotifyFS;
  bool spotifyPan;
  final html.IFrameElement _iframeElementURL = html.IFrameElement();


  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    _iframeElementURL.src = 'https://open.spotify.com/embed/playlist/1hJhyi1Ofxvlsswc1ZeXEs';
    _iframeElementURL.style.border = 'none';
    _iframeElementURL.allow = "autoplay; encrypted-media;";
    _iframeElementURL.allowFullscreen = true;
    ui.platformViewRegistry.registerViewFactory(
      'spotifyIframe',
          (int viewId) => _iframeElementURL,
    );

  }

  @override
  Widget build(BuildContext context) {
    var spotifyOpen = Provider.of<OnOff>(context).getSpotify;
    spotifyFS = Provider.of<OnOff>(context).getSpotifyFS;
    spotifyPan = Provider.of<OnOff>(context).getSpotifyPan;
    return spotifyOpen
        ? AnimatedPositioned(
      duration: Duration(milliseconds: spotifyPan ? 0 : 200),
      top: spotifyFS ? screenHeight(context, mulBy: 0.0335) : position.dy,
      left: spotifyFS ? 0 : position.dx,
      child: spotifyWindow(context),
    )
        : Container();
  }

  AnimatedContainer spotifyWindow(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: spotifyFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.7),
      height: spotifyFS
          ? screenHeight(context, mulBy: 0.863)
          : screenHeight(context, mulBy: 0.75),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: spotifyFS
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
                  if (!spotifyFS) {
                    setState(() {
                      position = Offset(position.dx + tapInfo.delta.dx,
                          position.dy + tapInfo.delta.dy);
                    });
                  }
                },
                onPanStart: (details) {
                  Provider.of<OnOff>(context, listen: false).onSpotifyPan();
                },
                onPanEnd: (details) {
                  Provider.of<OnOff>(context, listen: false).offSpotifyPan();
                },
                onDoubleTap: () {
                  Provider.of<OnOff>(context, listen: false).toggleSpotifyFS();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  width: spotifyFS
                      ? screenWidth(context, mulBy: 0.95)
                      : screenWidth(context, mulBy: 0.7),
                  height: spotifyFS
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
                                .toggleSpotify();
                            Provider.of<OnOff>(context, listen: false)
                                .offSpotifyFS();
                          },
                        ),
                        SizedBox(
                          width: screenWidth(context, mulBy: 0.005),
                        ),
                        InkWell(
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
                                .toggleSpotifyFS();
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
                    color: Theme.of(context).dividerColor.withOpacity(0.8),
                  ),
                  child: HtmlElementView(
                    viewType: 'spotifyIframe',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

