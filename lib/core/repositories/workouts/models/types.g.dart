// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypesAdapter extends TypeAdapter<Types> {
  @override
  final int typeId = 6;

  @override
  Types read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Types(
      typesList: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Types obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.typesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
