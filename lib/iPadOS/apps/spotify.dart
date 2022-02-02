import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../providers.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class Spotify extends StatefulWidget {
  final Offset initPos;
  const Spotify({this.initPos, Key key}) : super(key: key);

  @override
  _SpotifyState createState() => _SpotifyState();
}

class _SpotifyState extends State<Spotify> {
  final html.IFrameElement _iframeElementURL = html.IFrameElement();


  @override
  void initState() {
    super.initState();
    _iframeElementURL.src = 'https://open.spotify.com/embed/playlist/1hJhyi1Ofxvlsswc1ZeXEs';
    _iframeElementURL.style.border = 'none';
    _iframeElementURL.allow = "autoplay; encrypted-media;";
    _iframeElementURL.allowFullscreen = true;
    _iframeElementURL.height="100%";
    ui.platformViewRegistry.registerViewFactory(
      'spotifyIframe',
          (int viewId) => _iframeElementURL,
    );

  }

  @override
  Widget build(BuildContext context) {
    return spotifyWindow(context);
  }

  Widget spotifyWindow(BuildContext context) {
    return Scaler(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: screenWidth(context, ),
          height: screenHeight(context, ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff516176),
                Color(0xff0d0f12),
              ]
            )
          ),

          child: Column(
            children: [

              Container(
                height: screenHeight(context, mulBy: 0.04),
                color: Color(0xff516176),
              ),
              Expanded(
                child: HtmlElementView(
                  viewType: 'spotifyIframe',
                ),
              ),
              Container(
                height: screenHeight(context, mulBy: 0.05),
                color: Color(0xff0d0f12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

