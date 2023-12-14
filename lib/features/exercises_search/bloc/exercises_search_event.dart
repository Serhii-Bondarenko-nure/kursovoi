part of 'exercises_search_bloc.dart';

abstract class ExercisesSearchEvent extends Equatable {}

class ExerciseDetailsTapped extends ExercisesSearchEvent {
  ExerciseDetailsTapped({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}

class WorkoutCreateTapped extends ExercisesSearchEvent {
  WorkoutCreateTapped({required this.exercise});

  final Exercise exercise;

  @override
  List<Object?> get props => [exercise];
}

class LoadExercisesList extends ExercisesSearchEvent {
  @override
  List<Object?> get props => [];
}
