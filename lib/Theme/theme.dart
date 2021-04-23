import 'package:flutter/material.dart';
import 'sharedPref.dart';

class ThemeNotifier with ChangeNotifier {

  static bool isDark;

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Color(0xfff1f7fa),
    cardColor: Colors.blueGrey[50],
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey,
        decorationColor: Colors.blueGrey[300],
      ),
      subtitle1: TextStyle(
        color: Colors.black,
      ),
    ),
    bottomAppBarColor: Colors.blueGrey[900],
    iconTheme: IconThemeData(color: Colors.blueGrey),
   // brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    backgroundColor: Colors.black,
    cardColor: Color(0xff242b4b),
    scaffoldBackgroundColor: Color(0xff242b4b),
    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey[200],
        decorationColor: Colors.blueGrey[50],
      ),
      subtitle1: TextStyle(
        color: Colors.blueGrey[300],
      ),
    ),
    bottomAppBarColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.blueGrey[200]),
     brightness: Brightness.dark,
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  var themeMode;
  //bool dark=false;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
       // dark=false;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
       //dark=true;
      }
      notifyListeners();
    });
  }



  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();

  }

}
