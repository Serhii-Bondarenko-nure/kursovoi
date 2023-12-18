part of 'workout_create_bloc.dart';

abstract class WorkoutCreateState extends Equatable {}

class WorkoutCreateInitial extends WorkoutCreateState {
  @override
  List<Object?> get props => [];
}

class WorkoutCreateDataLoading extends WorkoutCreateState {
  @override
  List<Object?> get props => [];
}

class WorkoutCreateDataLoaded extends WorkoutCreateState {
  WorkoutCreateDataLoaded({
    required this.workout,
    required this.exercisesGifUrl,
  });

  final Workout workout;
  final List<String> exercisesGifUrl;

  @override
  List<Object?> get props => [workout, exercisesGifUrl];
}

class ExerciseDeleted extends WorkoutCreateState {
  @override
  List<Object?> get props => [];
}

class NextExercisesSearchPage extends WorkoutCreateState {
  NextExercisesSearchPage({required this.isWorkoutCreateScreen});

  final bool isWorkoutCreateScreen;

  @override
  List<Object?> get props => [isWorkoutCreateScreen];
}

class NextWorkoutsPage extends WorkoutCreateState {
  @override
  List<Object?> get props => [];
}

class WorkoutCreateErrorState extends WorkoutCreateState {
  WorkoutCreateErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
