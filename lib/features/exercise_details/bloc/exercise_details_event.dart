part of 'exercise_details_bloc.dart';

abstract class ExerciseDetailsEvent extends Equatable {}

class LoadExerciseDetailsEvent extends ExerciseDetailsEvent {
  LoadExerciseDetailsEvent({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
