part of 'exercise_details_bloc.dart';

abstract class ExerciseDetailsState extends Equatable {}

class ExerciseDetailsInitial extends ExerciseDetailsState {
  @override
  List<Object?> get props => [];
}

class ExerciseDetailsLoading extends ExerciseDetailsState {
  @override
  List<Object?> get props => [];
}

class ExerciseDetailsLoaded extends ExerciseDetailsState {
  ExerciseDetailsLoaded({required this.exercise});

  final Exercise exercise;

  @override
  List<Object?> get props => [exercise];
}

class ExerciseDetailsErrorState extends ExerciseDetailsState {
  ExerciseDetailsErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
