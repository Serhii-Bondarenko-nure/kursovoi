import 'package:authorization/core/consts/hive_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_card.g.dart';

@HiveType(typeId: IdHiveConstants.exerciseCardsBoxId)
@JsonSerializable()
class ExerciseCard extends Equatable {
  const ExerciseCard({
    required this.exerciseTime,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.sets,
    required this.repetitions,
    required this.target,
  });

  //можно сделать поле, которое явно будет указывать упражнение делается на время или по повторам
  //если на время то будет подключен функционал таймера
  @HiveField(0)
  final int exerciseTime;

  @HiveField(1)
  final String gifUrl;

  @HiveField(2)
  @JsonKey(
    toJson: _idToJson,
    fromJson: _idFromJson,
  )
  @HiveField(3)
  final int id;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final int sets;

  @HiveField(6)
  final int repetitions;

  @HiveField(7)
  final String target;

  factory ExerciseCard.fromJson(Map<String, dynamic> json) =>
      _$ExerciseCardFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseCardToJson(this);

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
        exerciseTime,
        gifUrl,
        id,
        name,
        sets,
        repetitions,
        target,
      ];
}
