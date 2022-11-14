

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mac_dt/components/wallpaper/wallpaper.dart';
import 'package:mac_dt/data/system_data.dart';
import 'package:mac_dt/theme/theme.dart';

class SystemDataCRUD{

  static Box<SystemData> getSystemData() =>
      Hive.box<SystemData>('systemData');


///Gets data from local database. If the database is empty(i.e being run the first time),
  ///then defaultValue is used.
  static WallData getWallpaper(){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
            wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        )
    );

    return systemData!.wallpaper;
  }

  ///Sets data to local database. If the database is empty(i.e being run the first time),
  ///then defaultValue is used. The change is being made to the value and is saved again.
  ///WallData had to be registered as Adapter to this to work.
  static setWallpaper(WallData? wallData){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
            wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        )
    );
    systemData!.wallpaper= wallData!;
    systemData.save();
  }


  ///Gets data from local database. If the database is empty(i.e being run the first time),
  ///then defaultValue is used.
  static ThemeData getTheme(){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
            wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        )
    );

    if(systemData!.dark)
      return ThemeNotifier.darkTheme;
    else
      return ThemeNotifier.lightTheme;
  }

  ///Sets data to local database. If the database is empty(i.e being run the first time),
  ///then defaultValue is used. The change is being made to the value and is saved again.
  static setTheme(ThemeData themeData){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
            wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        )
    );
    if(themeData==ThemeNotifier.darkTheme)
      systemData!.dark= true;
    else
      systemData!.dark= false;
    systemData.save();
  }
}