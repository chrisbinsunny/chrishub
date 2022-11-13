import 'package:hive/hive.dart';

import '../components/wallpaper.dart';
part 'system_data.g.dart';

@HiveType(typeId: 0)
class SystemData extends HiveObject {

  @HiveField(0,)
  WallData? wallpaper;

  @HiveField(1, )
  bool? dark;

}