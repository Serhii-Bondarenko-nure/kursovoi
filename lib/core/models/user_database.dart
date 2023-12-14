import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_database.g.dart';

@JsonSerializable()
class UserDatabase extends Equatable {
  const UserDatabase({
    //required this.userUid,
    //required this.isWorkouts,
    required this.workouts,
  });

  final List<Map<int, Workout>> workouts;

  factory UserDatabase.fromJson(Map<String, dynamic> json) =>
      _$UserDatabaseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDatabaseToJson(this);

  @override
  List<Object?> get props => [
        //userUid,
        //isWorkouts,
        workouts,
      ];
}
