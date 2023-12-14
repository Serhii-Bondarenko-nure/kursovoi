part of 'workout_card_bloc.dart';

abstract class WorkoutCardEvent extends Equatable {}

class LoadWorkoutsListByType extends WorkoutCardEvent {
  LoadWorkoutsListByType({required this.workoutType});

  final String workoutType;

  @override
  List<Object?> get props => [workoutType];
}

class CollapsedWorkoutsList extends WorkoutCardEvent {
  @override
  List<Object?> get props => [];
}
