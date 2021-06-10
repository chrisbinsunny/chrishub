import 'package:flutter/material.dart';

class MBPText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final FontWeight weight;
  final String fontFamily;
  const MBPText({this.color= Colors.black,this.text, this.size=12, this.weight, this.fontFamily, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text,style: TextStyle(
        fontWeight: weight==null?Theme.of(context).textTheme.headline4.fontWeight:weight,
        color: color,
        fontSize: size,
      ),textAlign: TextAlign.center,),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;
  final double spreadRadius;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
    this.spreadRadius = 0.0,

  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows)
        result.maskFilter = null;
      return true;
    }());
    return result;
  }
}