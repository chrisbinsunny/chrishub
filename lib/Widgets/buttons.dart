import 'dart:ui';

import 'package:flutter/material.dart';
import '../Theme/theme.dart';

// ignore: must_be_immutable
class DarkModeToggle extends StatefulWidget {
  ThemeNotifier theme;
  DarkModeToggle(this.theme);
  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends
State<DarkModeToggle> with
    SingleTickerProviderStateMixin{
  static bool isDark = false;
  Duration _duration = Duration(milliseconds: 370);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

   //isDark= !widget.theme.dark;
   // debugPrint(widget.theme.dark.toString());

    _animationController = AnimationController(
        vsync: this,
        duration: _duration,
      //value: widget.theme.dark?1:0,
    );

    _animation = AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight
    ).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child){
        return GestureDetector(
          onTap: (){
            setState(() {
              if(_animationController.isCompleted){
                _animationController.reverse();
              }else{
                _animationController.forward();
              }

              isDark = !isDark;
              isDark?widget.theme.setDarkMode():widget.theme.setLightMode();
            });
          },
          child: Container(
            width: size.width*0.043,
            height: size.height*0.04,
            padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
            decoration: BoxDecoration(
                color: isDark ?  Color(0xff0069ff):Color(0xffe5e8ed),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                      color: isDark ? Colors.white.withOpacity(0.2):Color(0xff010e28).withOpacity(0.1) ,
                      blurRadius: 9,
                      offset: Offset(2, 4)
                  ),
                  BoxShadow(
                      color: isDark ? Colors.white.withOpacity(0.2):Color(0xff010e28).withOpacity(0.1) ,
                      blurRadius: 8,
                      offset: Offset(-2, -4)
                  )
                ]
            ),
            child: Align(
              alignment: _animation.value,
              child: Container(
                width: size.height*0.04,
                height: size.height*0.04,
                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool getIsDark() => isDark;
}