part of 'workout_details_bloc.dart';

abstract class WorkoutDetailsEvent extends Equatable {}

class LoadWorkoutDetailsEvent extends WorkoutDetailsEvent {
  LoadWorkoutDetailsEvent({
    required this.workoutId,
    required this.isSearchScreen,
  });

  final int workoutId;
  final bool isSearchScreen;

  @override
  List<Object?> get props => [workoutId];
}

class AddWorkoutTapped extends WorkoutDetailsEvent {
  AddWorkoutTapped({required this.workout});

  final Workout workout;

  @override
  List<Object?> get props => [workout];
}

class StartWorkoutTapped extends WorkoutDetailsEvent {
  StartWorkoutTapped({required this.workout});

  final Workout workout;

  @override
  List<Object?> get props => [workout];
}

class RepeatWorkoutTapped extends WorkoutDetailsEvent {
  RepeatWorkoutTapped({required this.workout});

  final Workout workout;

  @override
  List<Object?> get props => [workout];
}

class ExerciseDetailsTapped extends WorkoutDetailsEvent {
  ExerciseDetailsTapped({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}
