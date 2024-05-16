// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      isComplete: json['isComplete'] as bool,
      isUserOwner: json['isUserOwner'] as bool,
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      descriptions: (json['descriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      exercises:
          Workout._exercisesFromJson(json['exercises'] as Map<String, dynamic>),
      minutesWorkoutTime: (json['minutesWorkoutTime'] as num).toInt(),
      lastComplete: json['lastComplete'] == null
          ? null
          : DateTime.parse(json['lastComplete'] as String),
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
      'lastComplete': instance.lastComplete?.toIso8601String(),
    };
