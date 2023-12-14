// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDatabase _$UserDatabaseFromJson(Map<String, dynamic> json) => UserDatabase(
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    int.parse(k), Workout.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
    );

Map<String, dynamic> _$UserDatabaseToJson(UserDatabase instance) =>
    <String, dynamic>{
      'workouts': instance.workouts
          .map((e) => e.map((k, e) => MapEntry(k.toString(), e)))
          .toList(),
    };
