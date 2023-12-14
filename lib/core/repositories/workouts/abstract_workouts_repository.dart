import 'package:authorization/core/repositories/workouts/models/models.dart';

abstract class AbstractWorkoutsRepository {
  Future<List<Workout>> getWorkoutsList();

  Future<Types> getTypesList();

  Future<Workout> getWorkoutById(int workoutId);
  Future<List<Workout>> getWorkoutsListByType(String workoutType);
}
