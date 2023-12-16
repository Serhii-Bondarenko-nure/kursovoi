import 'package:authorization/core/repositories/workouts/models/exercise_card.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

//@HiveType(typeId: IdHiveConstants.workoutsBoxId)
@JsonSerializable()
class Workout extends Equatable {
  const Workout({
    required this.id,
    required this.imageUrl,
    required this.isComplete,
    required this.isUserOwner,
    required this.name,
    required this.types,
    required this.descriptions,
    required this.exercises,
    required this.minutesWorkoutTime,
    required this.lastComplete,
  });

  //@HiveField(0)
  final int id;

  //@HiveField(1)
  final String imageUrl;

  //Отдых между упражнениями можно задавать в настройках или добавить специальное поле сюда и в json
  //Это нужно будет там для йоги и т.д.

  //@HiveField(2)
  final bool isComplete;

  //@HiveField(3)
  final bool isUserOwner;

  //@HiveField(4)
  final String name;

  //@HiveField(5)
  //@JsonKey(toJson: _typesToJson)
  final List<String> types;

  //@HiveField(6)
  //@JsonKey(toJson: _descriptionsToJson)
  final List<String> descriptions;

  // @HiveField(7)
  @JsonKey(toJson: _exercisesToJson, fromJson: _exercisesFromJson)
  final Map<int, ExerciseCard> exercises;

  // @HiveField(8)
  final int minutesWorkoutTime;

  //@HiveField(9)
  final DateTime? lastComplete;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  static Map<int, ExerciseCard> _exercisesFromJson(
          Map<String, dynamic> exercisesMap) =>
      exercisesMap.map((key, value) => MapEntry(
          int.parse(key.replaceAll(RegExp('[^0-9]'), '')),
          ExerciseCard.fromJson(value)));

  static Map<String, dynamic> _exercisesToJson(
          Map<int, ExerciseCard> exercisesMap) =>
      exercisesMap.map((key, value) => MapEntry("ex$key", value.toJson()));

  // static Map<String, dynamic> _typesToJson(List<String> typesList) {
  //   int i = 0;
  //   final Map<String, dynamic> typesListJson = {
  //     for (var item in typesList) "${i++}": item
  //   };
  //   return typesListJson;
  // }

  // static Map<String, dynamic> _descriptionsToJson(
  //     List<String> descriptionsList) {
  //   int i = 0;
  //   final Map<String, dynamic> descriptionsListJson = {
  //     for (var item in descriptionsList) "${i++}": item
  //   };
  //   return descriptionsListJson;
  // }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        isComplete,
        isUserOwner,
        name,
        types,
        descriptions,
        exercises,
        lastComplete,
      ];
}
