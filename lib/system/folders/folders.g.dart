// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderPropsAdapter extends TypeAdapter<FolderProps> {
  @override
  final int typeId = 2;

  @override
  FolderProps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderProps(
      name: fields[0] as String?,
      initPos: fields[1] as Offset?,
      renaming: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FolderProps obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.initPos)
      ..writeByte(2)
      ..write(obj.renaming);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderPropsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
