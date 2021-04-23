import 'package:flutter/material.dart';
import '../sizes.dart';
import '../Widgets/widgets.dart';
import 'pageItems.dart';

class Parallax extends StatefulWidget {
  final ScrollController scrollController;
  Parallax(this.scrollController);
  @override
  _ParallaxState createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  double rateZero = 0;
  double rateOne = 10;
  double rateTwo = 10;
  double rateThree = 10;
  double rateFour = 10;
  double rateFive = 10;
  double rateSix = 10;
  double rateSeven = 20;
  double rateEight = 70;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      // ignore: missing_return
      onNotification: (v) {
        if (v is ScrollUpdateNotification) {
          setState(() {
            rateEight -= v.scrollDelta / 1;
            rateSeven -= v.scrollDelta / 1.5;
            rateSix -= v.scrollDelta / 2;
            rateFive -= v.scrollDelta / 2.5;
            rateFour -= v.scrollDelta / 3;
            rateThree -= v.scrollDelta / 3.5;
            rateTwo -= v.scrollDelta / 4;
            rateOne -= v.scrollDelta / 4.5;
            rateZero -= v.scrollDelta / 5;
          });
        }
      },
      child: Stack(
        children: <Widget>[
          AddImage(top: rateZero, asset: "parallax0"),
          AddImage(top: rateOne, asset: "parallax1"),
          AddImage(top: rateTwo, asset: "parallax2"),
          AddImage(top: rateThree, asset: "parallax3"),
          AddImage(top: rateFour, asset: "parallax4"),
          AddImage(top: rateFive, asset: "parallax5"),
          AddImage(top: rateSix, asset: "parallax6"),
          AddImage(top: rateSeven, asset: "parallax7"),
          AddImage(top: rateEight, asset: "parallax8"),
          Positioned(
              top: screenHeight(context,mulBy: 0.4),
              left: screenWidth(context, mulBy: 0.1),
              child: Container(
                padding: EdgeInsets.only(bottom: 100),
                width: screenWidth(context,mulBy: 0.4),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "\"👋🏻Hello World!\n  I'm Chrisbin Sunny 🧑🏻‍💻\"\n",
                    style: TextStyle(fontSize: 58, ),
                    maxLines: 3,

                  ),
                ),
              )),
          // ListView(
          //   children: <Widget>[
          //     Container(
          //       height: screenHeight(context),
          //       color: Colors.transparent,
          //     ),
          //     Container(
          //       color: Color(0xff210002),
          //       width: double.infinity,
          //       padding: EdgeInsets.only(top: 70),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //           Container(
          //             height:screenHeight(context),
          //             width: screenWidth(context),
          //             color: Colors.deepOrange,
          //           ),
          //           Container(
          //             height:screenHeight(context),
          //             width: screenWidth(context),
          //
          //             color: Colors.lightGreenAccent,
          //           ),
          //           Container(
          //             height:screenHeight(context),
          //             width: screenWidth(context),
          //
          //             color: Colors.blue,
          //           ),
          //           Text(
          //             "Flutter",
          //             style: TextStyle(
          //                 fontSize: 51,
          //                 fontFamily: "MontSerrat-Regular",
          //                 letterSpacing: 1.8,
          //                 color: Color(0xffffaf00)),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           SizedBox(
          //             width: 190,
          //             child: Divider(
          //               height: 1,
          //               color: Color(0xffffaf00),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Text(
          //             "Made By",
          //             style: TextStyle(
          //               fontSize: 15,
          //               fontFamily: "Montserrat-Extralight",
          //               letterSpacing: 1.3,
          //               color: Color(0xffffaf00),
          //             ),
          //           ),
          //           Text(
          //             "The CS Guy",
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontFamily: "Montserrat-Regular",
          //               letterSpacing: 1.8,
          //               color: Color(0xffffaf00),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 50,
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          ListView.builder(
              controller: widget.scrollController,
              padding: EdgeInsets.zero,
              itemCount: pageItems.length,
              itemBuilder: (context, index) {
                return pageItems[index];
              }),
        ],
      ),
    );
  }
}
