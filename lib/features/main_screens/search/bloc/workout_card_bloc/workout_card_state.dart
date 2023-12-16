part of 'workout_card_bloc.dart';

abstract class WorkoutCardState extends Equatable {}

class WorkoutCardInitial extends WorkoutCardState {
  @override
  List<Object?> get props => [];
}

class WorkoutsListByTypeLoading extends WorkoutCardState {
  @override
  List<Object?> get props => [];
}

class WorkoutsListByTypeLoaded extends WorkoutCardState {
  WorkoutsListByTypeLoaded({required this.workoutsListByType});

  final List<Workout> workoutsListByType;

  @override
  List<Object?> get props => [workoutsListByType];
}

class WorkoutsListByTypeIsCollapsed extends WorkoutCardState {
  @override
  List<Object?> get props => [];
}

class WorkoutCardErrorState extends WorkoutCardState {
  WorkoutCardErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
