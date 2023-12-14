import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:authorization/core/repositories/workouts/abstract_workouts_repository.dart';
import 'package:authorization/core/repositories/workouts/models/models.dart';

class WorkoutsRepository extends AbstractWorkoutsRepository {
  WorkoutsRepository({
    required this.workoutBox,
    required this.exerciseCardBox,
    required this.typesBox,
  });

  Box<Workout> workoutBox;
  Box<ExerciseCard> exerciseCardBox;
  Box<Types> typesBox;

  @override
  Future<List<Workout>> getWorkoutsList() async {
    var workoutsList = <Workout>[];

    try {
      workoutsList = await _fetchWorkoutsListFromLocalJson();

      final workoutsmap = {for (var e in workoutsList) e.id: e};
      workoutBox.putAll(workoutsmap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      workoutsList = workoutBox.values.toList();
    }

    return workoutsList;
  }

  Future<List<Workout>> _fetchWorkoutsListFromLocalJson() async {
    final response = await rootBundle.loadString('assets/json/workouts.json');
    final data = await json.decode(response) as List<dynamic>;

    var workoutsList = (data.map((item) => Workout.fromJson(item)).toList());

    return workoutsList;
  }

  @override
  Future<Types> getTypesList() async {
    Types types;

    try {
      types = await _fetchTypesListFromLocalJson();

      typesBox.put(0, types);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      types = typesBox.values.single;
    }

    return types;
  }

  Future<Types> _fetchTypesListFromLocalJson() async {
    final response = await rootBundle.loadString('assets/json/types.json');

    final data = await json.decode(response) as List<dynamic>;
    final typesList = data.map((item) => item as String).toList();
    final types = Types(typesList: typesList);

    return types;
  }

  @override
  Future<Workout> getWorkoutById(int workoutId) async {
    Workout workout;

    try {
      workout = await _fetchWorkoutByIdFromLocalJson(workoutId);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      workout = workoutBox.values.firstWhere((item) => item.id == workoutId);
    }

    return workout;
  }

  Future<Workout> _fetchWorkoutByIdFromLocalJson(int workoutId) async {
    final response = await _fetchWorkoutsListFromLocalJson();

    final workout = response.firstWhere((item) => item.id == workoutId);

    return workout;
  }

  @override
  Future<List<Workout>> getWorkoutsListByType(String workoutType) async {
    var workoutsList = <Workout>[];

    try {
      workoutsList = await _fetchWorkoutsListTypeFromLocalJson(workoutType);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      workoutsList = workoutBox.values
          .where((item) => item.types.contains(workoutType))
          .toList();
    }

    return workoutsList;
  }

  Future<List<Workout>> _fetchWorkoutsListTypeFromLocalJson(
      String workoutType) async {
    final response = await _fetchWorkoutsListFromLocalJson();

    final workoutsList =
        response.where((item) => item.types.contains(workoutType)).toList();

    return workoutsList;
  }
}
