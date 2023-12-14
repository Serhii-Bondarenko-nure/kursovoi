import 'package:authorization/core/consts/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@HiveType(typeId: IdHiveConstants.exercisesBoxId)
@JsonSerializable()
class Exercise extends Equatable {
  const Exercise({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  @HiveField(0)
  final String bodyPart;

  @HiveField(1)
  final String equipment;

  @HiveField(2)
  final String gifUrl;

  @HiveField(3)
  @JsonKey(
    toJson: _idToJson,
    fromJson: _idFromJson,
  )
  final int id;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final String target;

  @HiveField(6)
  final List<String> secondaryMuscles;

  @HiveField(7)
  final List<String> instructions;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  static String _idToJson(int id) {
    String idToString = "";
    for (var i = 0; i < 4 - "$id".length; i++) {
      idToString += "0";
    }
    String idString = "$idToString$id";
    return idString;
  }

  static int _idFromJson(String id) => int.parse(id);

  @override
  List<Object?> get props => [
        bodyPart,
        equipment,
        gifUrl,
        id,
        name,
        target,
        secondaryMuscles,
        instructions,
      ];
}
