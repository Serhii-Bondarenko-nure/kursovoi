import 'dart:async';
import 'dart:convert';

import 'package:authorization/core/repositories/exercises/exercises_backup/abstract_exercises_backup_repository.dart';
import 'package:authorization/core/repositories/exercises/models/body_parts.dart';
import 'package:authorization/core/repositories/exercises/models/equipment.dart';
import 'package:authorization/core/repositories/exercises/models/exercise.dart';
import 'package:authorization/core/repositories/exercises/models/target_muscles.dart';
import 'package:flutter/services.dart';

class ExersicesBackupRepository implements AbstractExersicesBackupRepository {
  //Exercises List
  @override
  Future<List<Exercise>> fetchExercisesListFromLocalJson() async {
    final response = await rootBundle.loadString('assets/json/exercises.json');
    final data = await json.decode(response) as List<dynamic>;

    var exercisesList = (data.map((item) => Exercise.fromJson(item)).toList());

    return exercisesList;
  }

  //Target Muscles, Equipment, BodyParts Lists
  @override
  Future<TargetMuscles> fetchTargetMusclesListFromLocalJson() async {
    final response = await rootBundle.loadString('assets/json/targetList.json');

    final data = await json.decode(response) as List<dynamic>;
    final targetMusclesList = data.map((item) => item as String).toList();
    final targetMuscles = TargetMuscles(targetMusclesList: targetMusclesList);

    return targetMuscles;
  }

  @override
  Future<Equipment> fetchEquipmentListFromLocalJson() async {
    final response =
        await rootBundle.loadString('assets/json/equipmentList.json');

    final data = await json.decode(response) as List<dynamic>;
    final equipmentList = data.map((item) => item as String).toList();
    final equipment = Equipment(equipmentList: equipmentList);

    return equipment;
  }

  @override
  Future<BodyParts> fetchBodyPartsListFromLocalJson() async {
    final response =
        await rootBundle.loadString('assets/json/bodyPartList.json');

    final data = await json.decode(response) as List<dynamic>;
    final bodyPartsList = data.map((item) => item as String).toList();
    final bodyParts = BodyParts(bodyPartsList: bodyPartsList);

    return bodyParts;
  }

  //Exercise by id, name
  @override
  Future<Exercise> fetchExerciseByIdFromLocalJson(int exerciseId) async {
    final response = await fetchExercisesListFromLocalJson();

    final exercise = response.firstWhere((item) => item.id == exerciseId);

    return exercise;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByNameFromLocalJson(
      String exerciseName) async {
    final response = await fetchExercisesListFromLocalJson();

    final exercisesList =
        response.where((item) => item.name.contains(exerciseName)).toList();

    return exercisesList;
  }

  //Exercises Lists by Target Muscles, Equipment, BodyParts
  @override
  Future<List<Exercise>> fetchExercisesListByTargetMuscleFromLocalJson(
      String targetMuscle) async {
    final response = await fetchExercisesListFromLocalJson();

    final exercisesList =
        response.where((item) => item.target == targetMuscle).toList();

    return exercisesList;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByEquipmentTypeFromLocalJson(
      String equipmentType) async {
    final response = await fetchExercisesListFromLocalJson();

    final exercisesList = response
        .where((item) => item.equipment == equipmentType) as List<Exercise>;

    return exercisesList;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByBodyPartFromLocalJson(
      String bodyPart) async {
    final response = await fetchExercisesListFromLocalJson();

    final exercisesList =
        response.where((item) => item.bodyPart == bodyPart) as List<Exercise>;

    return exercisesList;
  }
}
