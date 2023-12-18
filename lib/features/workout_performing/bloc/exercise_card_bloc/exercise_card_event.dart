part of 'exercise_card_bloc.dart';

abstract class ExerciseCardEvent extends Equatable {}

class LoadExerciseCard extends ExerciseCardEvent {
  LoadExerciseCard({
    required this.exerciseNumber,
  });

  final int exerciseNumber;

  @override
  List<Object?> get props => [exerciseNumber];
}

class ExerciseSetTapped extends ExerciseCardEvent {
  ExerciseSetTapped({
    required this.exerciseNumber,
    required this.setNumber,
    required this.flag,
  });

  final int exerciseNumber;
  final int setNumber;
  final bool flag;

  @override
  List<Object?> get props => [exerciseNumber, setNumber];
}
