part of 'workout_performing_bloc.dart';

abstract class WorkoutPerformingState extends Equatable {}

class WorkoutPerformingInitial extends WorkoutPerformingState {
  @override
  List<Object?> get props => [];
}

class WorkoutPerformingDataLoading extends WorkoutPerformingState {
  @override
  List<Object?> get props => [];
}

class WorkoutPerformingDataLoaded extends WorkoutPerformingState {
  WorkoutPerformingDataLoaded({
    required this.workout,
    required this.exercisesGifUrl,
  });

  final Workout workout;
  final List<String> exercisesGifUrl;

  @override
  List<Object?> get props => [workout, exercisesGifUrl];
}

class NextStaticticsPage extends WorkoutPerformingState {
  @override
  List<Object?> get props => [];
}

class NextExerciseDetailsPage extends WorkoutPerformingState {
  NextExerciseDetailsPage({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}

class WorkoutPerformingErrorState extends WorkoutPerformingState {
  WorkoutPerformingErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
