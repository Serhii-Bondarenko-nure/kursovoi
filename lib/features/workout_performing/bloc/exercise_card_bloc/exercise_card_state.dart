part of 'exercise_card_bloc.dart';

abstract class ExerciseCardState extends Equatable {}

class ExerciseCardInitial extends ExerciseCardState {
  @override
  List<Object?> get props => [];
}

class ExerciseCardLoading extends ExerciseCardState {
  @override
  List<Object?> get props => [];
}

class ExerciseCardLoaded extends ExerciseCardState {
  ExerciseCardLoaded({
    required this.flags,
  });

  final Map<int, bool> flags;

  @override
  List<Object?> get props => [flags];
}

class NextReloadExerciseCard extends ExerciseCardState {
  @override
  List<Object?> get props => [];
}

class ExerciseCardErrorState extends ExerciseCardState {
  ExerciseCardErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
