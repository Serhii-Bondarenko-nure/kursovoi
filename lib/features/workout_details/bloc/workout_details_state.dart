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
  WorkoutDetailsLoaded({
    required this.workout,
    required this.exercisesGifUrl,
  });

  final Workout workout;
  final List<String> exercisesGifUrl;

  @override
  List<Object?> get props => [workout, exercisesGifUrl];
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

class NextExerciseDetailsPage extends WorkoutDetailsState {
  NextExerciseDetailsPage({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}

class ShowWorkoutSettingsPage extends WorkoutDetailsState {
  ShowWorkoutSettingsPage({
    required this.workoutId,
    required this.isUserOwner,
    required this.isSearchScreen,
  });

  final int workoutId;
  final bool isUserOwner;
  final bool isSearchScreen;

  @override
  List<Object?> get props => [
        workoutId,
        isUserOwner,
        isSearchScreen,
      ];
}

class WorkoutDetailsErrorState extends WorkoutDetailsState {
  WorkoutDetailsErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
