// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_card.dart';

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
