// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseCardAdapter extends TypeAdapter<ExerciseCard> {
  @override
  final int typeId = 5;

  @override
  ExerciseCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseCard(
      exerciseTime: fields[0] as int,
      gifUrl: fields[1] as String,
      id: fields[2] as int,
      name: fields[4] as String,
      sets: fields[5] as int,
      repetitions: fields[6] as int,
      target: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseCard obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.exerciseTime)
      ..writeByte(1)
      ..write(obj.gifUrl)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.sets)
      ..writeByte(6)
      ..write(obj.repetitions)
      ..writeByte(7)
      ..write(obj.target);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseCard _$ExerciseCardFromJson(Map<String, dynamic> json) => ExerciseCard(
      exerciseTime: json['exerciseTime'] as int,
      gifUrl: json['gifUrl'] as String,
      id: ExerciseCard._idFromJson(json['id'] as String),
      name: json['name'] as String,
      sets: json['sets'] as int,
      repetitions: json['repetitions'] as int,
      target: json['target'] as String,
    );

Map<String, dynamic> _$ExerciseCardToJson(ExerciseCard instance) =>
    <String, dynamic>{
      'exerciseTime': instance.exerciseTime,
      'gifUrl': instance.gifUrl,
      'id': ExerciseCard._idToJson(instance.id),
      'name': instance.name,
      'sets': instance.sets,
      'repetitions': instance.repetitions,
      'target': instance.target,
    };
