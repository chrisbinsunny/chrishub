import 'package:flutter/material.dart';
import '../sizes.dart';

class ShowCase extends StatefulWidget {
  @override
  _ShowCaseState createState() => _ShowCaseState();
}

class _ShowCaseState extends State<ShowCase> {
  @override
  Widget build(BuildContext context) {
    return Container(height:screenHeight(context),
      width: screenWidth(context),
      color: Colors.greenAccent,);
  }
}
