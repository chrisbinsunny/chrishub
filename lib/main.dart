import 'package:flutter/material.dart';

import 'desktop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Big Sur',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "SF",
      ),
      home: MyHomePage(),
    );
  }
}
