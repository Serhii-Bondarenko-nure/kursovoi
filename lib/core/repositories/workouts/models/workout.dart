import 'package:authorization/core/consts/hive_constants.dart';
import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@HiveType(typeId: IdHiveConstants.workoutsBoxId)
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
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imageUrl;

  //Отдых между упражнениями можно задавать в настройках или добавить специальное поле сюда и в json
  //Это нужно будет там для йоги и т.д.

  //Выполнена тренировка или нет
  //Для отрисовки карточки тренировки и некоторой логики экрана деталей тренировки
  //true - на карточке будет показано, что она выполнена
  // На экране деталей тренировки кнопка "Старт" будет заменена на "Выполнить еще раз"
  // После нажатия сразу перезапишется это поле на false
  // false - на карточке не будет никаких доп деталей
  // На экране деталей тренировки кнопка "Старт" будет работать в штатном режиме
  @HiveField(2)
  final bool isComplete;

  //Владелец тренировки приложение или пользователь
  //true - пользователь, для кнопки редактирвования и функционала редактирвоания тренировки
  @HiveField(3)
  final bool isUserOwner;

  @HiveField(4)
  final String name;

  @HiveField(5)
  //@JsonKey(toJson: _typesToJson)
  final List<String> types;

  @HiveField(6)
  //@JsonKey(toJson: _descriptionsToJson)
  final List<String> descriptions;

  @HiveField(7)
  @JsonKey(toJson: _exercisesToJson)
  final List<ExerciseCard> exercises;

  @HiveField(8)
  final int minutesWorkoutTime;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  static List<Map<String, dynamic>> _exercisesToJson(
          List<ExerciseCard> exercisesList) =>
      exercisesList.map((item) => item.toJson()).toList();

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
      ];
}
