part of 'workout_performing_bloc.dart';

abstract class WorkoutPerformingEvent extends Equatable {}

class LoadWorkoutPerformingData extends WorkoutPerformingEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutCompleteTapped extends WorkoutPerformingEvent {
  WorkoutCompleteTapped({required this.workoutId});

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class ExerciseDetailsTapped extends WorkoutPerformingEvent {
  ExerciseDetailsTapped({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}
