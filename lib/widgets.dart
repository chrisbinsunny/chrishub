import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mac_dt/providers.dart';
import 'package:provider/provider.dart';

class MBPText extends StatelessWidget {
  final Color color;
  final String? text;
  final double size;
  final FontWeight? weight;
  final String fontFamily;
  final int maxLines;
  final TextOverflow overflow;
  final bool softWrap;
  const MBPText({this.color= Colors.black,this.text, this.size=12, this.weight, this.fontFamily="SF", this.maxLines=1, this.softWrap=true, this.overflow= TextOverflow.fade, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text!,
        style: TextStyle(
        fontWeight: weight==null?Theme.of(context).textTheme.headline4!.fontWeight:weight,
        fontFamily: fontFamily,
        color: color,
        fontSize: size,

      ),
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,

      ),
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

class Scaler extends StatelessWidget {
  Widget? child;
  Scaler({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scale= Provider.of<DataBus>(context).getScale;
    return Transform.scale(
      scale: scale,
      alignment: Alignment.topCenter,
      child: child
    );
  }
}


BoxConstraints constraints({double? height, width}){
  return BoxConstraints(
      minHeight: height==null?0:height*800, ///800 is the safe height factor
    minWidth: width==null?0:width*800
  );
}



extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String getInitials() => this.isNotEmpty
      ? this.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}


showAlertDialog(BuildContext context) {

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { },
  );

  AlertDialog alert = AlertDialog(

    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// class Minimiser extends StatefulWidget {
//   Minimiser({Key? key, this.minimise=false,  this.child}) : super(key: key);
//
//   bool minimise;
//   Widget? child;
//   @override
//   _MinimiserState createState() => _MinimiserState();
// }
//
// class _MinimiserState extends State<Minimiser> {
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//
//
//       transform: Matrix4.translation(0000,0,0,0),
//       child: widget.child,
//     );
//   }
// }


///Night Shift Blender
class BlendMask extends SingleChildRenderObjectWidget {
  final BlendMode blendMode;
  final double opacity;

  BlendMask({
    required this.blendMode,
    this.opacity = 1.0,
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(context) {
    return RenderBlendMask(blendMode, opacity);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBlendMask renderObject) {
    renderObject.blendMode = blendMode;
    renderObject.opacity = opacity;
  }
}

class RenderBlendMask extends RenderProxyBox {
  BlendMode blendMode;
  double opacity;

  RenderBlendMask(this.blendMode, this.opacity);

  @override
  void paint(context, offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = blendMode
        ..color = Color.fromARGB((opacity * 255).round(), 255, 255, 255),
    );

    super.paint(context, offset);

    context.canvas.restore();
  }
}