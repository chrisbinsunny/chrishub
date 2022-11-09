import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mac_dt/system/folders.dart';
import 'package:mac_dt/iOS.dart';
import 'package:mac_dt/iPadOS/iPadOS.dart';
import 'package:mac_dt/platformFinder.dart';
import 'package:mac_dt/providers.dart';
import 'package:mac_dt/sizes.dart';
import 'system/openApps.dart';
import 'theme/theme.dart';
import 'package:mac_dt/system/componentsOnOff.dart';
import 'package:provider/provider.dart';

import 'system/desktop.dart';
import 'dart:html' as html;

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
        ChangeNotifierProvider<DataBus>(
          create: (context) => DataBus(),
        ),
        ChangeNotifierProvider<Apps>(
          create: (context) => Apps(),
        ),
        ChangeNotifierProvider<Folders>(
          create: (context) => Folders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chrisbin\'s MacBook Pro',
        theme: themeNotifier.getTheme(),
        home: PlatformFinder(
            macOS: MacOS(),
          ipadOS: IPadOS(),
          iOS: IOS(),
        ),
      ),
    );
  }
}