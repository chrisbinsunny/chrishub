import 'package:flutter/material.dart';
import '../sizes.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Container(height:screenHeight(context),
      width: screenWidth(context),
      color: Colors.blue,);
  }
}
