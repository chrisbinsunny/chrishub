import 'package:flutter/material.dart';

class MBPText extends StatelessWidget {
  final String text;
  const MBPText({this.text, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(text,style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 12,
      ),textAlign: TextAlign.center,),
    );
  }
}
