part of 'workout_history_bloc.dart';

abstract class WorkoutsHistoryState extends Equatable {}

class WorkoutsHistoryInitial extends WorkoutsHistoryState {
  @override
  List<Object?> get props => [];
}

class WorkoutsHistoryLoading extends WorkoutsHistoryState {
  @override
  List<Object?> get props => [];
}

class WorkoutsHistoryLoaded extends WorkoutsHistoryState {
  WorkoutsHistoryLoaded({
    required this.workouts,
  });

  final List<Workout> workouts;

  @override
  List<Object?> get props => [workouts];
}

class WorkoutsHistoryErrorState extends WorkoutsHistoryState {
  WorkoutsHistoryErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
