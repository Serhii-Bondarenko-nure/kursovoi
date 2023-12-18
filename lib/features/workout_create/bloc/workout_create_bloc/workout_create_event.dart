part of 'workout_create_bloc.dart';

abstract class WorkoutCreateEvent extends Equatable {}

class LoadWorkoutCreateData extends WorkoutCreateEvent {
  @override
  List<Object?> get props => [];
}

class AddExerciseTapped extends WorkoutCreateEvent {
  @override
  List<Object?> get props => [];
}

class SaveWorkoutTapped extends WorkoutCreateEvent {
  @override
  List<Object?> get props => [];
}

class DeleteExerciseTapped extends WorkoutCreateEvent {
  DeleteExerciseTapped({required this.exercisesNumber});

  final int exercisesNumber;

  @override
  List<Object?> get props => [exercisesNumber];
}
