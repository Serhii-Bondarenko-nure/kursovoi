// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_muscles.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetMusclesAdapter extends TypeAdapter<TargetMuscles> {
  @override
  final int typeId = 3;

  @override
  TargetMuscles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TargetMuscles(
      targetMusclesList: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TargetMuscles obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.targetMusclesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetMusclesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
