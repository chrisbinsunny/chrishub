// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WallDataAdapter extends TypeAdapter<WallData> {
  @override
  final int typeId = 1;

  @override
  WallData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WallData(
      name: fields[0] as String,
      location: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WallData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
