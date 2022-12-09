import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mac_dt/data/analytics.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:mac_dt/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../system/openApps.dart';
import '../../sizes.dart';
import '../../widgets.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;



class About extends StatefulWidget {
  final Offset? initPos;
  const About({this.initPos, Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Offset? position = Offset(0.0, 0.0);
  late bool aboutFS;
  late bool aboutPan;
  late bool aboutOpen;
  String selected = "About";
  final html.IFrameElement _iframeElementURL = html.IFrameElement();


  @override
  void initState() {
    position = widget.initPos;
    super.initState();
    _iframeElementURL.src = 'https://drive.google.com/file/d/1cuIQHOhjvZfM_M74HjsICNpuzvMO0uKX/preview';
    _iframeElementURL.style.border = 'none';
    _iframeElementURL.allow = "autoplay; encrypted-media;";
    _iframeElementURL.allowFullscreen = true;
    ui.platformViewRegistry.registerViewFactory(
      'resumeIframe',
          (int viewId) => _iframeElementURL,
    );
    Provider.of<AnalyticsService>(context, listen: false)
        .logCurrentScreen("About me");
  }



  getContent(){
    switch(selected){
      case "About":
        return Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context, mulBy: 0.02),
                ),
                Container(
                  child: Image.asset(
                    "assets/sysPref/chrisbin.jpg",
                    fit: BoxFit.cover,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration:
                  BoxDecoration(shape: BoxShape.circle),
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.02),
                ),
                RichText(
                  text: TextSpan(
                    text: "Hey, I am ",
                    children: [
                      TextSpan(
                        text: "Chrisbin Sunny,\n",
                        style: TextStyle(
                          color: Color(0xff118bff),
                        )
                      ),
                      TextSpan(
                          text: "App Developer from India 🇮🇳",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          )
                      )
                    ],
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context)
                          .cardColor
                          .withOpacity(1),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1
                    )
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.03),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🏠     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                         "I am a CS Engineering graduate from SJCET, Palai. I now work as a freelance"
                            " App Developer. ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.015),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "👨‍💻     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "I mostly use Flutter for building all kinds of projects. "
                            "Currently, I am trying to bring more out of Flutter Web.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.015),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🏅     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "I have conducted several sessions and hands-on workshops at colleges."
                            "All the sessions was on Flutter.",


                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.015),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🎯     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Programming was always my area of interest since teenage.Currently on a mission to make clean"
                            "app UI/UX",


                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.015),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "📲     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Feel free to email me at chrisbinofficial@gmail.com",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case "Education":
        return Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context, mulBy: 0.02),
                ),
                Text(
                    "Education",
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1
                    )
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.03),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🧿     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "2018-2021\n",
                          children: [
                            TextSpan(
                              text: "St. Joesph's College of Engineering & Technology, Palai\n",
                              style: TextStyle(
                                color: Color(0xff118bff),

                              ),
                            ),
                            TextSpan(
                              text: "Btech\nComputer Science and Engineering",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            )
                          ],
                          style: TextStyle(
                          fontSize: 17,
                          fontFamily: "HN",
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                            letterSpacing: 1
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🧿     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "2017-2018\n",
                          children: [
                            TextSpan(
                              text: "Believer's Church Caarmel Engineering College\n",
                              style: TextStyle(
                                color: Color(0xff118bff),

                              ),
                            ),
                            TextSpan(
                              text: "Btech\nComputer Science and Engineering",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            )
                          ],
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "HN",

                              fontWeight: FontWeight.w700,
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(1),
                              letterSpacing: 1
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🧿     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "2015-2017\n",
                          children: [
                            TextSpan(
                              text: "Holy Cross Vidya Sadan, Thellakom\n",
                              style: TextStyle(
                                color: Color(0xff118bff),

                              ),
                            ),
                            TextSpan(
                              text: "AISSCE\nComputer Science",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            )
                          ],
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "HN",

                              fontWeight: FontWeight.w700,
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(1),
                              letterSpacing: 1
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🧿     ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "2005-2015\n",
                          children: [
                            TextSpan(
                              text: "Holy Cross Vidya Sadan, Thellakom\n",
                              style: TextStyle(
                                color: Color(0xff118bff),

                              ),
                            ),
                            TextSpan(
                              text: "AISSE",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                            )
                          ],
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: "HN",

                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(1),
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        break;
      case "Skills":
        return Container(
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.02),
                      ),
                      Text(
                          "Languages & Tools",
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(1),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1
                          )
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.03),
                      ),
                      Text(
                        "🧿     GoLang",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Dart",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Python",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     C",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     HTML5",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Firebase",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Git",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.02),
                      ),
                      Text(
                          "Frameworks & others",
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context)
                                  .cardColor
                                  .withOpacity(1),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1
                          )
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.03),
                      ),
                      Text(
                        "🧿     Flutter",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Photoshop",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     DialogFlow",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Gaming",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     Premiere Pro",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                      SizedBox(
                        height: screenHeight(context, mulBy: 0.015),
                      ),
                      Text(
                        "🧿     After Effwcts",
                        style: TextStyle(
                            fontFamily: "HN",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(1),
                            letterSpacing: 1
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case "Projects":
        return Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(context, mulBy: 0.02),
                ),
                Text(
                    "Open Projects",
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(1),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1
                    )
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.04),
                ),
                InkWell(
                  onTap: (){
                    html.window.open('https://chrisbinsunny.github.io/chrishub', 'new tab');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👨‍💻     ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Chrisbin's Macbook Pro\n",
                            children: [
                              TextSpan(
                                text: "chrisbinsunny.github.io/chrishub\n",
                                style: TextStyle(
                                  color: Color(0xff118bff),
                                    fontWeight: FontWeight.w500,
                                  fontSize: 15
                                ),
                              ),
                              TextSpan(
                                text: "A portfolio website created as a web Simulation of macOS Big Sur."
                                    " The idea is to provide a glimpse at my personal system.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13
                                ),
                              )
                            ],
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "HN",
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(1),
                                letterSpacing: 1
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.025),
                ),
                InkWell(
                  onTap: (){
                    html.window.open('https://chrisbinsunny.github.io/dream', 'new tab');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👨‍💻     ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "DREAM\n",
                            children: [
                              TextSpan(
                                text: "chrisbinsunny.github.io/dream\n",
                                style: TextStyle(
                                    color: Color(0xff118bff),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),
                              ),
                              TextSpan(
                                text: "A utility website used to find "
                                  "colours from images and screenshots. "
                              "There’s also a gradient builder to build"
                              " beautiful background for websites.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13
                                ),
                              )
                            ],
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "HN",
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(1),
                                letterSpacing: 1
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.025),
                ),
                InkWell(
                  onTap: (){
                    html.window.open('https://chrisbinsunny.github.io/Flutter-Talks', 'new tab');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👨‍💻     ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Flutter Talks\n",
                            children: [
                              TextSpan(
                                text: "chrisbinsunny.github.io/Flutter-Talks\n",
                                style: TextStyle(
                                    color: Color(0xff118bff),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),
                              ),
                              TextSpan(
                                text: "The project is basically a Flutter intro "
                                  " slideshow presentation used in workshops.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13
                                ),
                              )
                            ],
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "HN",
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(1),
                                letterSpacing: 1
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, mulBy: 0.025),
                ),
                InkWell(
                  onTap: (){
                    html.window.open('https://chrisbinsunny.github.io', 'new tab');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👨‍💻     ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(1),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "Old Portfolio\n",
                            children: [
                              TextSpan(
                                text: "chrisbinsunny.github.io\n",
                                style: TextStyle(
                                    color: Color(0xff118bff),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),
                              ),
                              TextSpan(
                                text: "The portfolio website while I was a real noob.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13
                                ),
                              )
                            ],
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "HN",
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(1),
                                letterSpacing: 1
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case "Resume":
        //html.window.open('https://drive.google.com/uc?export=download&id=1cuIQHOhjvZfM_M74HjsICNpuzvMO0uKX', '_self');
        return Container(
          width: screenWidth(
            context,
          ),
          child: HtmlElementView(
            viewType: 'resumeIframe',
          ),
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    aboutOpen = Provider.of<OnOff>(context).getAbout;
    aboutFS = Provider.of<OnOff>(context).getAboutFS;
    aboutPan = Provider.of<OnOff>(context).getAboutPan;
    return aboutOpen
        ? AnimatedPositioned(
            duration: Duration(milliseconds: aboutPan ? 0 : 200),
            top:
                aboutFS ? screenHeight(context, mulBy: 0.0335) : position!.dy,
            left: aboutFS ? 0 : position!.dx,
            child: aboutWindow(context),
          )
        : Nothing();
  }

  AnimatedContainer aboutWindow(BuildContext context) {
    String topApp = Provider.of<Apps>(context).getTop;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: aboutFS
          ? screenWidth(context, mulBy: 1)
          : screenWidth(context, mulBy: 0.58),
      height: aboutFS
          ?screenHeight(context, mulBy: 0.966)
          : screenHeight(context, mulBy: 0.7),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).dialogBackgroundColor,
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
        alignment: Alignment.topCenter,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        border: Border(
                            right: BorderSide(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.3),
                                width: 0.6))),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, mulBy: 0.01),
                        vertical: screenHeight(context, mulBy: 0.05)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight(context, mulBy: 0.03),
                        ),
                        AboutWindowItems(
                          icon: CupertinoIcons.person_fill,
                          iName: "About Chrisbin",
                          isSelected: selected=="About",
                          onTap: (){
                            setState(() {
                              selected = "About";
                            });
                          },
                        ),
                        AboutWindowItems(
                          icon: CupertinoIcons.book_fill,
                          iName: "Education",
                          isSelected: selected=="Education",
                          onTap: (){
                            setState(() {
                              selected = "Education";
                            });
                          },
                        ),
                        AboutWindowItems(
                          icon: CupertinoIcons.hammer_fill,
                          iName: "Skills",
                          isSelected: selected=="Skills",
                          onTap: (){
                            setState(() {
                              selected = "Skills";
                            });
                          },
                        ),
                        AboutWindowItems(
                          icon: CupertinoIcons.device_desktop,
                          iName: "Open Projects",
                          isSelected: selected=="Projects",
                          onTap: (){
                            setState(() {
                              selected = "Projects";
                            });
                          },
                        ),
                        AboutWindowItems(
                          icon: CupertinoIcons.folder_fill,
                          iName: "Resume",
                          isSelected: selected=="Resume",
                          onTap: (){
                            setState(() {
                              selected = "Resume";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, mulBy: 0.02),
                          vertical: screenHeight(context, mulBy: 0.05)),
                      duration: Duration(milliseconds: 200),
                      width: screenWidth(context, mulBy: aboutFS ? .78 : .43),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      child: getContent(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onPanUpdate: (tapInfo) {
              if (!aboutFS) {
                setState(() {
                  position = Offset(position!.dx + tapInfo.delta.dx,
                      position!.dy + tapInfo.delta.dy);
                });
              }
            },
            onPanStart: (details) {
              Provider.of<OnOff>(context, listen: false).onAboutPan();
            },
            onPanEnd: (details) {
              Provider.of<OnOff>(context, listen: false).offAboutPan();
            },
            onDoubleTap: () {
              Provider.of<OnOff>(context, listen: false).toggleAboutFS();
            },
            child: Container(
              alignment: Alignment.topRight,
              width: aboutFS
                  ? screenWidth(context, mulBy: 0.95)
                  : screenWidth(context, mulBy: 0.7),
              height: aboutFS
                  ? screenHeight(context, mulBy: 0.059)
                  : screenHeight(context, mulBy: 0.06),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context, mulBy: 0.013),
                vertical: screenHeight(context, mulBy: 0.02)),
            child: Row(
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
                    Provider.of<OnOff>(context, listen: false).toggleAbout();
                    Provider.of<OnOff>(context, listen: false).offAboutFS();
                    Provider.of<Apps>(context, listen: false).closeApp("about");
                  },
                ),
                SizedBox(
                  width: screenWidth(context, mulBy: 0.005),
                ),
                InkWell(
                  onTap: (){
                    Provider.of<OnOff>(context, listen: false).toggleAbout();
                    Provider.of<OnOff>(context, listen: false).offAboutFS();
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
                        .toggleAboutFS();
                  },
                )
              ],
            ),
          ),


    Visibility(
    visible: topApp != "About Me",
    child: InkWell(
    onTap: (){
    Provider.of<Apps>(context, listen: false)
        .bringToTop(ObjectKey("about"));
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


class AboutWindowItems extends StatefulWidget {
  bool isSelected;
  final String? iName;
  final IconData icon;
  VoidCallback? onTap;
  AboutWindowItems({
    this.isSelected=false,
    this.iName,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _AboutWindowItemsState createState() => _AboutWindowItemsState();
}

class _AboutWindowItemsState extends State<AboutWindowItems> {
  bool hovering= false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (evnt){
          setState(() {
            hovering=true;
          });
        },
        onExit: (evnt){
          setState(() {
            hovering=false;
          });
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: 7
          ),
          decoration: BoxDecoration(
              color: widget.isSelected?Colors.blueAccent.withOpacity(0.14):
              hovering ? Colors.blueAccent.withOpacity(0.14) : Colors.transparent
              ,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          alignment: Alignment.centerLeft,
          width: screenWidth(context,),
          padding: EdgeInsets.only(left: screenWidth(context,mulBy: 0.005)),
          height: screenHeight(context,mulBy: 0.038),
          child: Row(
            children: [
              Icon(widget.icon, color: Theme.of(context).cardColor.withOpacity(1),),
              MBPText(
                text: "    ${widget.iName}",
                size: 14,
                color: Theme.of(context).cardColor.withOpacity(1),

              ),
            ],
          ),
        ),
      ),
    );
  }
}