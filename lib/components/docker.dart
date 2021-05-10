import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../sizes.dart';

class Docker extends StatefulWidget {
  const Docker({
    Key key,
  }) : super(key: key);

  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 70.0, sigmaY: 70.0),
              child: Column(
                children: [
                  SizedBox(height:screenHeight(context,mulBy: 0.09)),
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    width: screenWidth(context,mulBy: 0.7),
                    height: screenHeight(context,mulBy: 0.09),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DockerItem(iName: "finder",on: true,),
                        DockerItem(iName: "launchpad",on: false,),
                        DockerItem(iName: "safari",on: false,),
                        DockerItem(iName: "messages",on: false,),
                        DockerItem(iName: "maps",on: false,),
                        DockerItem(iName: "mail",on: false,),
                        DockerItem(iName: "terminal",on: false,),
                        DockerItem(iName: "xcode",on: false,),
                        DockerItem(iName: "photos",on: false,),
                        DockerItem(iName: "contacts",on: false,),
                        DockerItem(iName: "calendar",on: false,),
                        DockerItem(iName: "notes",on: false,),
                        DockerItem(iName: "appstore",on: false,),
                        DockerItem(iName: "system-preferences",on: false,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context,mulBy:0.01),
          )
        ],
      ),
    );
  }

}

class DockerItem extends StatefulWidget {
  final String iName;
  final bool on;
  DockerItem({
    Key key,
    @required this.iName,
    this.on =false,
  }) : super(key: key);

  @override
  _DockerItemState createState() => _DockerItemState();
}

class _DockerItemState extends State<DockerItem> {
  final containerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //print('absolute coordinates on screen: ${containerKey.globalPaintBounds} ');

    return Container(
    key: containerKey,
    child: Column(
      children: [
        Expanded(child: Container(child: Image.asset("assets/apps/${widget.iName}.png",)).moveUpOnHover),
        Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: widget.on?Colors.black:Colors.transparent,
            shape: BoxShape.circle,
          ),
        )
      ],
    ),
  ).showCursorOnHover;
  }

}

extension GlobalKeyExtension on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null)?.getTranslation();
    if (translation != null && renderObject.paintBounds != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  // You can also pass the translation in here if you want to
  TranslateOnHover({Key key, this.child}) : super(key: key);

  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..scale(1.4,1.4)..translate(-5, -20, 0, );

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        child: widget.child,
        transform: _hovering ? hoverTransform : nonHoverTransform,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }



}

extension HoverExtensions on Widget {
  // Get a reference to the body of the view
  static final appContainer =
  html.window.document.getElementById("app-container");

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      // When the mouse enters the widget set the cursor to pointer
      onHover: (event) {
        appContainer.style.cursor = 'pointer';
      },
      // When it exits set it back to default
      onExit: (event) {
        appContainer.style.cursor = 'default';
      },
    );
  }

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}