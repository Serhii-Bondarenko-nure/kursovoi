// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 4;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      id: fields[0] as int,
      imageUrl: fields[1] as String,
      isComplete: fields[2] as bool,
      isUserOwner: fields[3] as bool,
      name: fields[4] as String,
      types: (fields[5] as List).cast<String>(),
      descriptions: (fields[6] as List).cast<String>(),
      exercises: (fields[7] as List).cast<ExerciseCard>(),
      minutesWorkoutTime: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.isComplete)
      ..writeByte(3)
      ..write(obj.isUserOwner)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.descriptions)
      ..writeByte(7)
      ..write(obj.exercises)
      ..writeByte(8)
      ..write(obj.minutesWorkoutTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      isComplete: json['isComplete'] as bool,
      isUserOwner: json['isUserOwner'] as bool,
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      descriptions: (json['descriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      minutesWorkoutTime: json['minutesWorkoutTime'] as int,
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'isComplete': instance.isComplete,
      'isUserOwner': instance.isUserOwner,
      'name': instance.name,
      'types': instance.types,
      'descriptions': instance.descriptions,
      'exercises': Workout._exercisesToJson(instance.exercises),
      'minutesWorkoutTime': instance.minutesWorkoutTime,
    };
