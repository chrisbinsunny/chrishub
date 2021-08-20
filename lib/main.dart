import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mac_dt/providers.dart';
import 'openApps.dart';
import 'theme/theme.dart';
import 'package:mac_dt/componentsOnOff.dart';
import 'package:provider/provider.dart';

import 'desktop.dart';

void main() {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeNotifier.darkTheme),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnOff>(
          create: (context) => OnOff(),
        ),
        ChangeNotifierProvider<BackBone>(
          create: (context) => BackBone(),
        ),
        ChangeNotifierProvider<Apps>(
          create: (context) => Apps(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chrisbin\'s MacBook Pro',
        theme: themeNotifier.getTheme(),
        home: MyHomePage(),
      ),
    );
  }
}