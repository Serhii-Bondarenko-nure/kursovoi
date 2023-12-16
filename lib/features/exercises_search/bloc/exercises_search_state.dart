part of 'exercises_search_bloc.dart';

abstract class ExercisesSearchState extends Equatable {}

class ExercisesSearchInitial extends ExercisesSearchState {
  @override
  List<Object?> get props => [];
}

class ExercisesListLoading extends ExercisesSearchState {
  @override
  List<Object?> get props => [];
}

class ExercisesListLoaded extends ExercisesSearchState {
  ExercisesListLoaded({required this.exercisesList});

  final List<Exercise> exercisesList;

  @override
  List<Object?> get props => [exercisesList];
}

class NextExerciseDetailsPage extends ExercisesSearchState {
  NextExerciseDetailsPage({required this.exerciseId});

  final int exerciseId;

  @override
  List<Object?> get props => [exerciseId];
}

class NextWorkoutCreatePage extends ExercisesSearchState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ExercisesSearchState {
  ErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
