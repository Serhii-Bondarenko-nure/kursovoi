part of 'workout_details_bloc.dart';

abstract class WorkoutDetailsState extends Equatable {}

class WorkoutDetailsInitial extends WorkoutDetailsState {
  @override
  List<Object?> get props => [];
}

class WorkoutDetailsLoading extends WorkoutDetailsState {
  @override
  List<Object?> get props => [];
}

class WorkoutDetailsLoaded extends WorkoutDetailsState {
  WorkoutDetailsLoaded({required this.workout});

  final Workout workout;

  @override
  List<Object?> get props => [workout];
}

class NextWorkoutsPage extends WorkoutDetailsState {
  @override
  List<Object?> get props => [];
}

class NextWorkoutPerformingPage extends WorkoutDetailsState {
  NextWorkoutPerformingPage({required this.workout});

  final Workout workout;

  @override
  List<Object?> get props => [workout];
}

class WorkoutDetailsErrorState extends WorkoutDetailsState {
  WorkoutDetailsErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}

class NextExerciseDetailsPage extends WorkoutDetailsState {
  NextExerciseDetailsPage({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}
