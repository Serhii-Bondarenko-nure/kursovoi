import 'package:authorization/core/repositories/exercises/models/models.dart';

abstract class AbstractExersicesApiRepository {
  Future<List<Exercise>> fetchExercisesListFromApi();

  Future<TargetMuscles> fetchTargetMusclesListFromApi();
  Future<Equipment> fetchEquipmentListFromApi();
  Future<BodyParts> fetchBodyPartsListFromApi();

  Future<Exercise> fetchExerciseByIdFromApi(int exerciseId);
  Future<List<Exercise>> fetchExercisesListByNameFromApi(String exerciseName);

  Future<List<Exercise>> fetchExercisesListByEquipmentTypeFromApi(
      String equipmentType);
  Future<List<Exercise>> fetchExercisesListByTargetMuscleFromApi(
      String targetMuscle);
  Future<List<Exercise>> fetchExercisesListByBodyPartFromApi(String bodyPart);
}
