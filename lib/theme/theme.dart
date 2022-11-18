import 'package:flutter/material.dart';
import 'package:mac_dt/data/system_data_CRUD.dart';

class ThemeNotifier with ChangeNotifier {

  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
        headline4: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      headline1: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
        headline3: TextStyle(
          fontWeight: FontWeight.w600,
        ),//iMessage info name
        headline2: TextStyle(                 //calendar heading
          fontWeight: FontWeight.w400,
          fontSize: 15,
        )
    ),
    fontFamily: "SF",
    primarySwatch: Colors.blueGrey,
    indicatorColor: Colors.white,  //Calendar bg color
    shadowColor: Colors.black.withOpacity(0.15), //Control Center outer border
    accentColor: Colors.black.withOpacity(.15), //shadow color
    backgroundColor: Colors.white.withOpacity(0.15), //Control Center
    cardColor: Colors.black.withOpacity(0.0), //Control Center item border, font color
    splashColor: Colors.black.withOpacity(0.2), //Control Center border
    focusColor: Colors.white.withOpacity(0.4), //docker color
    canvasColor: Colors.blue.withOpacity(0.4), //fileMenu Color
    scaffoldBackgroundColor: Colors.white, //window Color
    hintColor: Colors.white.withOpacity(0.6), //window transparency Color
    dividerColor: Colors.white, // Safari Window color
    dialogBackgroundColor: Colors.white, //feedback body color
    disabledColor: Colors.white, //terminal top color
    errorColor: Colors.white.withOpacity(0.3), //iMessages color
    hoverColor: Colors.white.withOpacity(0.4), // RCM color
    highlightColor:Colors.black.withOpacity(.13),//darkMode button
    bottomAppBarColor: Colors.black.withOpacity(0.1), //CC Music Color
    selectedRowColor: Color(0xffffffff).withOpacity(0.5),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xffbfbfbf), //feedback light color
        background: Color(0xff898989),  //feedback dark color
      error: Color(0xffcecece), //feedback textbox fill
      primary: Color(0xff232220),
      onError: Colors.white, //system Pref 1
      errorContainer: Color(0xffe9e9e7), //system Pref 2
      inversePrimary: Color(0xff80807e), //system Pref 2 text color
    ),

    primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey,
        decorationColor: Colors.blueGrey[300],
      ),
      subtitle1: TextStyle(
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.blueGrey),


  );

  static final ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: "SF"
      ),
        ///iMessage info name
        headline3: TextStyle(
            fontWeight: FontWeight.w500,
        ),
        headline1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        ///calendar heading
        headline2: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 15,
        )

    ),
    fontFamily: "SF",
    primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0xff2b2b2b).withOpacity(.05), //Control Center
    cardColor: Colors.white.withOpacity(0.15), //Control Center item border, font color
    indicatorColor: Colors.black,  //Calendar bg color, ipad messages left color
      splashColor: Colors.black.withOpacity(0.4), //Control Center border
      shadowColor: Colors.black.withOpacity(0.3), //Control Center outer border
      accentColor: Colors.black.withOpacity(.2), //shadow color
      focusColor: Color(0xff393232).withOpacity(0.2), //docker color
      canvasColor: Colors.black.withOpacity(0.3), //fileMenu Color
      scaffoldBackgroundColor: Color(0xff242127), //Finder window Color
      dividerColor: Color(0xff3a383e), // Window top color
      hintColor: Color(0xff242127).withOpacity(0.3), //window transparency Color
      dialogBackgroundColor: Color(0xff1e1f23), //feedback body color
      disabledColor: Color(0xff39373b), //terminal top color
      errorColor: Color(0xff1e1e1e).withOpacity(0.4), //iMessages color, Fill color
      hoverColor: Color(0xff110f0f).withOpacity(0.4), // RCM color
    bottomAppBarColor: Colors.white.withOpacity(0.3), //CC Music Color
    selectedRowColor: Color(0xff111111).withOpacity(0.7),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Color(0xff3b3b3b), //feedback light color
      background: Color(0xff2f2f2f),  //feedback dark color
        error: Color(0xff2f2e32), //feedback textbox fill
      primary: Color(0xff232220),
      onError: Color(0xff1f1e1d), //system Pref 1
      errorContainer: Color(0xff272624), //system Pref 2 ///Color(0xffe9e9e7)
      inversePrimary: Colors.grey, //system Pref 2 text color ///Color(0xff80807e)

    ),

      primaryTextTheme: TextTheme(
      button: TextStyle(
        color: Colors.blueGrey[200],
        decorationColor: Colors.blueGrey[50],
      ),
      subtitle1: TextStyle(
        color: Colors.blueGrey[300],
      ),
    ),
    iconTheme: IconThemeData(color: Colors.blueGrey[200]),
      highlightColor: Colors.white, //darkMode button
  );

  ThemeData _themeData;
  ThemeNotifier(this._themeData);
  getTheme() => _themeData;

  isDark() => _themeData==lightTheme?false:true;


  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    SystemDataCRUD.setTheme(themeData);
    notifyListeners();
  }

}
