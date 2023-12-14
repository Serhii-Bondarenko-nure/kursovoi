import 'package:authorization/core/repositories/exercises/models/models.dart';

abstract class AbstractExersicesBackupRepository {
  Future<List<Exercise>> fetchExercisesListFromLocalJson();

  Future<TargetMuscles> fetchTargetMusclesListFromLocalJson();
  Future<Equipment> fetchEquipmentListFromLocalJson();
  Future<BodyParts> fetchBodyPartsListFromLocalJson();

  Future<Exercise> fetchExerciseByIdFromLocalJson(int exerciseId);
  Future<List<Exercise>> fetchExercisesListByNameFromLocalJson(
      String exerciseName);

  Future<List<Exercise>> fetchExercisesListByEquipmentTypeFromLocalJson(
      String equipmentType);
  Future<List<Exercise>> fetchExercisesListByTargetMuscleFromLocalJson(
      String targetMuscle);
  Future<List<Exercise>> fetchExercisesListByBodyPartFromLocalJson(
      String bodyPart);
}
