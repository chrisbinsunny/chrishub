

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mac_dt/components/wallpaper.dart';
import 'package:mac_dt/data/system_data.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

class SystemDataCRUD{

  static Box<SystemData> getSystemData() =>
      Hive.box<SystemData>('systemData');

  static void startSystem(BuildContext context){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
          wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        ));

    Provider.of<DataBus>(context,
        listen: false)
        .setWallpaper(systemData!.wallpaper!);
}


  static WallData getWallpaper(){

    final box= getSystemData();
    SystemData? systemData= box.get(
        'systemData',
        defaultValue: SystemData(
            dark: true,
            wallpaper: WallData(name: "Big Sur Illustration", location: "assets/wallpapers/bigsur_.jpg")
        )
    );

    return systemData!.wallpaper!;
  }

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

}