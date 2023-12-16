part of 'workout_settings_bottmo_shett_bloc.dart';

abstract class WorkoutSettingsEvent extends Equatable {}

class CopyTapped extends WorkoutSettingsEvent {
  CopyTapped({required this.workoutId});

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class ChangeTapped extends WorkoutSettingsEvent {
  ChangeTapped({required this.workoutId});

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class DeleteTapped extends WorkoutSettingsEvent {
  DeleteTapped({required this.workoutId});

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}
