// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 0;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      bodyPart: fields[0] as String,
      equipment: fields[1] as String,
      gifUrl: fields[2] as String,
      id: fields[3] as int,
      name: fields[4] as String,
      target: fields[5] as String,
      secondaryMuscles: (fields[6] as List).cast<String>(),
      instructions: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.bodyPart)
      ..writeByte(1)
      ..write(obj.equipment)
      ..writeByte(2)
      ..write(obj.gifUrl)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.target)
      ..writeByte(6)
      ..write(obj.secondaryMuscles)
      ..writeByte(7)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      bodyPart: json['bodyPart'] as String,
      equipment: json['equipment'] as String,
      gifUrl: json['gifUrl'] as String,
      id: Exercise._idFromJson(json['id'] as String),
      name: json['name'] as String,
      target: json['target'] as String,
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'bodyPart': instance.bodyPart,
      'equipment': instance.equipment,
      'gifUrl': instance.gifUrl,
      'id': Exercise._idToJson(instance.id),
      'name': instance.name,
      'target': instance.target,
      'secondaryMuscles': instance.secondaryMuscles,
      'instructions': instance.instructions,
    };
