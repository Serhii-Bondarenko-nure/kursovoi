part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent extends Equatable {}

class WorkoutDetailsTapped extends SearchScreenEvent {
  WorkoutDetailsTapped({
    required this.workoutId,
  });

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class LoadTypesList extends SearchScreenEvent {
  @override
  List<Object?> get props => [];
}
