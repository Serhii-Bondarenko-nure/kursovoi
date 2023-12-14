part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {}

class LoadWorkoutsList extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutDetailsTapped extends WorkoutEvent {
  WorkoutDetailsTapped({
    required this.workoutId,
  });

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class WorkoutCreateTapped extends WorkoutEvent {
  @override
  List<Object?> get props => [];
}

class WorkoutDeleteTapped extends WorkoutEvent {
  WorkoutDeleteTapped({required this.workoutId});

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}
