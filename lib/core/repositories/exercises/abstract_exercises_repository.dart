import 'package:authorization/core/repositories/exercises/models/models.dart';

abstract class AbstractExersicesRepository {
  Future<List<Exercise>> getExercisesList();

  Future<TargetMuscles> getTargetMusclesList();
  Future<Equipment> getEquipmentList();
  Future<BodyParts> getBodyPartsList();

  Future<Exercise> getExerciseById(int exerciseId);
  Future<List<Exercise>> getExercisesListByName(String exerciseName);

  Future<List<Exercise>> getExercisesListByEquipmentType(String equipmentType);
  Future<List<Exercise>> getExercisesListByTargetMuscle(String targetMuscle);
  Future<List<Exercise>> getExercisesListByBodyPart(String bodyPart);

  Future<bool> getInitListsDataToLocalStorage();
}
