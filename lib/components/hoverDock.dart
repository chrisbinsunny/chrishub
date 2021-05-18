
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;

import 'package:mac_dt/sizes.dart';


class TranslateOnHover extends StatefulWidget {
  final Widget child;
  // You can also pass the translation in here if you want to
  TranslateOnHover({Key key, this.child}) : super(key: key);

  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..scale(1.2,1.2)..translate(-5, -25, 0, );

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        child: widget.child,
        transform: _hovering ? hoverTransform: nonHoverTransform,
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