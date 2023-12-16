part of 'workout_settings_bottmo_shett_bloc.dart';

abstract class WorkoutSettingsState extends Equatable {}

class WorkoutSettingsInitial extends WorkoutSettingsState {
  @override
  List<Object?> get props => [];
}

class NextCreateWorkoutPage extends WorkoutSettingsState {
  @override
  List<Object?> get props => [];
}

class NextWorkoutsPage extends WorkoutSettingsState {
  @override
  List<Object?> get props => [];
}

class WorkoutErrorState extends WorkoutSettingsState {
  WorkoutErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
