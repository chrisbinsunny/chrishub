import 'package:flutter/cupertino.dart';
import '../Pages/contact.dart';
import '../Pages/fppView.dart';
import '../Pages/showcase.dart';
import '../sizes.dart';
import 'package:flutter/material.dart';

List<Widget> pageItems = [
  ParallaxViewTransparent(),
  //FppView(),
  ShowCase(),
  Contact(),
];

class ParallaxViewTransparent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight(context),
          width: screenWidth(context),
          color: Theme.of(context).backgroundColor,
          child: (Theme.of(context).backgroundColor == Color(0xfff1f7fa))
              ? Image.asset("assets/light/openImg.jpg", fit: BoxFit.cover)
              : Image.asset("assets/dark/openImg.jpg", fit: BoxFit.cover),
        ),
        Positioned(
            top: screenHeight(context,mulBy: 0.55),
            left: screenWidth(context, mulBy: 0.08),
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              width: screenWidth(context,mulBy: 0.4),
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.none,
                child: Text(
                  "\"👋🏻Hello World!\n  I'm Chrisbin Sunny. 🧑🏻‍💻\"\n",
                  style: TextStyle(fontSize: 58, ),
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
              ),
            )),
      ],
    );
  }
}

//
