// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:authorization/core/repositories/exercises/models/body_parts.dart';
import 'package:authorization/core/repositories/exercises/models/equipment.dart';
import 'package:authorization/core/repositories/exercises/models/exercise.dart';
import 'package:authorization/core/repositories/exercises/models/target_muscles.dart';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/exercises/exercises_api/exercises_api.dart';
import 'package:authorization/core/repositories/exercises/exercises_backup/exercises_backup.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ExersicesRepository implements AbstractExersicesRepository {
  ExersicesRepository({
    required this.exersicesApiRepository,
    required this.exersicesBackupRepository,
    required this.exercisesBox,
    required this.targetMusclesBox,
    required this.equipmentBox,
    required this.bodyPartsBox,
    this.isApiEnable = true,
  });

  final ExersicesApiRepository exersicesApiRepository;
  final ExersicesBackupRepository exersicesBackupRepository;

  final Box<Exercise> exercisesBox;
  final Box<TargetMuscles> targetMusclesBox;
  final Box<Equipment> equipmentBox;
  final Box<BodyParts> bodyPartsBox;

  final bool isApiEnable;

  //Exercises List
  @override
  Future<List<Exercise>> getExercisesList() async {
    var exercisesList = <Exercise>[];

    try {
      exercisesList = !isApiEnable
          ? await exersicesBackupRepository.fetchExercisesListFromLocalJson()
          : await exersicesApiRepository.fetchExercisesListFromApi();

      final exercisesmap = {for (var e in exercisesList) e.id: e};
      exercisesBox.putAll(exercisesmap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercisesList = exercisesBox.values.toList();
    }

    return exercisesList;
  }

  //Target Muscles, Equipment, BodyParts Lists
  @override
  Future<TargetMuscles> getTargetMusclesList() async {
    TargetMuscles targetMuscles;

    try {
      targetMuscles = !isApiEnable
          ? await exersicesBackupRepository
              .fetchTargetMusclesListFromLocalJson()
          : await exersicesApiRepository.fetchTargetMusclesListFromApi();

      targetMusclesBox.put(0, targetMuscles);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      targetMuscles = targetMusclesBox.values.single;
    }

    return targetMuscles;
  }

  @override
  Future<Equipment> getEquipmentList() async {
    Equipment equipment;

    try {
      equipment = !isApiEnable
          ? await exersicesBackupRepository.fetchEquipmentListFromLocalJson()
          : await exersicesApiRepository.fetchEquipmentListFromApi();

      equipmentBox.put(0, equipment);
      //throw Exception("fds");
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      equipment = equipmentBox.values.single;
    }

    return equipment;
  }

  @override
  Future<BodyParts> getBodyPartsList() async {
    BodyParts bodyParts;

    try {
      bodyParts = !isApiEnable
          ? await exersicesBackupRepository.fetchBodyPartsListFromLocalJson()
          : await exersicesApiRepository.fetchBodyPartsListFromApi();

      bodyPartsBox.put(0, bodyParts);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      bodyParts = bodyPartsBox.values.single;
    }

    return bodyParts;
  }

  //Exercise by id, name
  @override
  Future<Exercise> getExerciseById(int exerciseId) async {
    Exercise exercise;

    try {
      exercise = !isApiEnable
          ? await exersicesBackupRepository
              .fetchExerciseByIdFromLocalJson(exerciseId)
          : await exersicesApiRepository.fetchExerciseByIdFromApi(exerciseId);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercise =
          exercisesBox.values.firstWhere((item) => item.id == exerciseId);
    }

    return exercise;
  }

  @override
  Future<List<Exercise>> getExercisesListByName(String exerciseName) async {
    var exercisesList = <Exercise>[];

    try {
      exercisesList = !isApiEnable
          ? await exersicesBackupRepository
              .fetchExercisesListByNameFromLocalJson(exerciseName)
          : await exersicesApiRepository
              .fetchExercisesListByNameFromApi(exerciseName);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercisesList = exercisesBox.values
          .where((item) => item.name.contains(exerciseName))
          .toList();
    }

    return exercisesList;
  }

  //Exercises Lists by Target Muscles, Equipment, BodyParts
  @override
  Future<List<Exercise>> getExercisesListByTargetMuscle(
      String targetMuscle) async {
    var exercisesList = <Exercise>[];

    try {
      exercisesList = !isApiEnable
          ? await exersicesBackupRepository
              .fetchExercisesListByTargetMuscleFromLocalJson(targetMuscle)
          : await exersicesApiRepository
              .fetchExercisesListByTargetMuscleFromApi(targetMuscle);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercisesList = exercisesBox.values
          .where((item) => item.target == targetMuscle)
          .toList();
    }

    return exercisesList;
  }

  @override
  Future<List<Exercise>> getExercisesListByEquipmentType(
      String equipmentType) async {
    var exercisesList = <Exercise>[];

    try {
      exercisesList = !isApiEnable
          ? await exersicesBackupRepository
              .fetchExercisesListByEquipmentTypeFromLocalJson(equipmentType)
          : await exersicesApiRepository
              .fetchExercisesListByEquipmentTypeFromApi(equipmentType);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercisesList = exercisesBox.values
          .where((item) => item.equipment == equipmentType)
          .toList();
    }

    return exercisesList;
  }

  @override
  Future<List<Exercise>> getExercisesListByBodyPart(String bodyPart) async {
    var exercisesList = <Exercise>[];

    try {
      exercisesList = !isApiEnable
          ? await exersicesBackupRepository
              .fetchExercisesListByBodyPartFromLocalJson(bodyPart)
          : await exersicesApiRepository
              .fetchExercisesListByBodyPartFromApi(bodyPart);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      exercisesList = exercisesBox.values
          .where((item) => item.bodyPart == bodyPart)
          .toList();
    }

    return exercisesList;
  }

  //Этот метод пока не нужен, может потом сделаю, пока он просто ломает приложение
  // final success =
  //     GetIt.I<ExersicesRepository>().getInitListsDataToLocalStorage;
  // GetIt.I<Talker>().log(
  //     "Loading the necessary data from the server into local storage when the application starts. Status: $success");
  @override
  Future<bool> getInitListsDataToLocalStorage() async {
    var exercisesList = <Exercise>[];
    TargetMuscles targetMuscles;
    Equipment equipment;
    BodyParts bodyParts;

    try {
      if (!isApiEnable) {
        exercisesList =
            await exersicesBackupRepository.fetchExercisesListFromLocalJson();

        targetMuscles = await exersicesBackupRepository
            .fetchTargetMusclesListFromLocalJson();
        equipment =
            await exersicesBackupRepository.fetchEquipmentListFromLocalJson();
        bodyParts =
            await exersicesBackupRepository.fetchBodyPartsListFromLocalJson();
      } else {
        exercisesList =
            await exersicesApiRepository.fetchExercisesListFromApi();

        targetMuscles =
            await exersicesApiRepository.fetchTargetMusclesListFromApi();
        equipment = await exersicesApiRepository.fetchEquipmentListFromApi();
        bodyParts = await exersicesApiRepository.fetchBodyPartsListFromApi();
      }

      final exercisesmap = {for (var e in exercisesList) e.id: e};
      exercisesBox.putAll(exercisesmap);

      targetMusclesBox.put(0, targetMuscles);
      equipmentBox.put(0, equipment);
      bodyPartsBox.put(0, bodyParts);

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }
}
