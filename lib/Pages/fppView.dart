import 'dart:ui';

import 'package:flutter/material.dart';
import '../sizes.dart';

class FppView1 extends StatefulWidget {
  @override
  _FppView1State createState() => _FppView1State();
}

class _FppView1State extends State<FppView1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      color: Theme.of(context).backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                // will be 10 by default if not provided
                sigmaX: 35,
                sigmaY: 35,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(context, mulBy: 0.02), vertical: screenHeight(context, mulBy: 0.05)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.1),
                ),
                height: screenHeight(context, mulBy: 0.7),
                width: screenWidth(context, mulBy: 0.27),
                child: Column(
                  children: [
                    Text(
                      "CHRISBIN SUNNY",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                    ),
                    SizedBox(height: screenHeight(context,mulBy: 0.005),),
                    Text(
                      "MOBILE DEVELOPER",
                      style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18),
                    ),
                    SizedBox(height: screenHeight(context,mulBy: 0.02),),
                    Text(
                      "Hi, My name is Chrisbin. I turn design into code. Coffee☕️ + Swags👕 == Perfection returns a true for me. \n"
                      "I am doing my final year B.Tech in Computer Science and Engineering at  St. Josephs College of Engineering and Technology, Palai, Kerala, India.\n"
                       "I usually work on Flutter, Dart, Firebase and Python. I have experience in Android, iOS apps and web.\n"
                          "I have also done projects in Chatbot development and Actions on Google \n\n",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 15,
                      style: TextStyle(
                        height: 1.4
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      height: screenHeight(context,mulBy: 0.05),
                      width: screenWidth(context,mulBy: 0.13),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget FppView(context){
  return Container(
    height: screenHeight(context),
    width: screenWidth(context),
    color: Theme.of(context).backgroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ClipRect(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(
        //       // will be 10 by default if not provided
        //       sigmaX: 35,
        //       sigmaY: 35,
        //     ),
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: screenWidth(context, mulBy: 0.02), vertical: screenHeight(context, mulBy: 0.05)),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //         color: Colors.white.withOpacity(0.1),
        //       ),
        //       height: screenHeight(context, mulBy: 0.7),
        //       width: screenWidth(context, mulBy: 0.27),
        //       child: Column(
        //         children: [
        //           Text(
        //             "CHRISBIN SUNNY",
        //             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
        //           ),
        //           SizedBox(height: screenHeight(context,mulBy: 0.005),),
        //           Text(
        //             "MOBILE DEVELOPER",
        //             style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18),
        //           ),
        //           SizedBox(height: screenHeight(context,mulBy: 0.02),),
        //           Text(
        //             "Hi, My name is Chrisbin. I turn design into code. Coffee☕️ + Swags👕 == Perfection returns a true for me. \n"
        //                 "I am doing my final year B.Tech in Computer Science and Engineering at  St. Josephs College of Engineering and Technology, Palai, Kerala, India.\n"
        //                 "I usually work on Flutter, Dart, Firebase and Python. I have experience in Android, iOS apps and web.\n"
        //                 "I have also done projects in Chatbot development and Actions on Google. \n\n",
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 15,
        //             style: TextStyle(
        //                 height: 1.4
        //             ),
        //           ),
        //           Container(
        //             decoration: BoxDecoration(
        //               color: Colors.blue,
        //             ),
        //             height: screenHeight(context,mulBy: 0.05),
        //             width: screenWidth(context,mulBy: 0.13),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Column(
          children: [
            Text(
              "CHRISBIN SUNNY",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
            ),
            SizedBox(height: screenHeight(context,mulBy: 0.005),),
            Text(
              "MOBILE DEVELOPER",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18),
            ),
            SizedBox(height: screenHeight(context,mulBy: 0.02),),
            Text(
              "Hi, My name is Chrisbin. I turn design into code. Coffee☕️ + Swags👕 == Perfection returns a true for me. \n"
                  "I am doing my final year B.Tech in Computer Science and Engineering at  St. Josephs College of Engineering and Technology, Palai, Kerala, India.\n"
                  "I usually work on Flutter, Dart, Firebase and Python. I have experience in Android, iOS apps and web.\n"
                  "I have also done projects in Chatbot development and Actions on Google. \n\n",
              overflow: TextOverflow.ellipsis,
              maxLines: 15,
              style: TextStyle(
                  height: 1.4
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              height: screenHeight(context,mulBy: 0.05),
              width: screenWidth(context,mulBy: 0.13),
            )
          ],
        ),
      ],
    ),
  );
}