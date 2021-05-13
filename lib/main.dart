import 'package:flutter/material.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:provider/provider.dart';
import 'dart:html';

import 'desktop.dart';

void main() {
  document.documentElement.requestFullscreen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: OnOff(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Big Sur',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "SF",
        ),
        home: MyHomePage(),
      ),
    );
  }
}