part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {}

class WorkoutInitial extends WorkoutState {
  @override
  List<Object?> get props => [];
}

class WorkoutsListLoading extends WorkoutState {
  @override
  List<Object?> get props => [];
}

class WorkoutsListLoaded extends WorkoutState {
  WorkoutsListLoaded({required this.workoutsList});

  final List<Workout> workoutsList;

  @override
  List<Object?> get props => [workoutsList];
}

class NextWorkoutDetailsPage extends WorkoutState {
  NextWorkoutDetailsPage({
    required this.workoutId,
  });

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class NextCreateWorkoutPage extends WorkoutState {
  @override
  List<Object?> get props => [];
}

class WorkoutErrorState extends WorkoutState {
  WorkoutErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
