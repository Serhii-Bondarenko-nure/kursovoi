// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_parts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyPartsAdapter extends TypeAdapter<BodyParts> {
  @override
  final int typeId = 1;

  @override
  BodyParts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyParts(
      bodyPartsList: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BodyParts obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bodyPartsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyPartsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
