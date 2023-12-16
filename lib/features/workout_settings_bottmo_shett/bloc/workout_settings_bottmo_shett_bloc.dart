import 'dart:async';

import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_settings_bottmo_shett_event.dart';
part 'workout_settings_bottmo_shett_state.dart';

class WorkoutSettingsBloc
    extends Bloc<WorkoutSettingsEvent, WorkoutSettingsState> {
  WorkoutSettingsBloc({
    required this.workoutCreateService,
    required this.userWorkoutsService,
  }) : super(WorkoutSettingsInitial()) {
    on<CopyTapped>(_copyTapped);
    on<ChangeTapped>(_changeTapped);
    on<DeleteTapped>(_deleteTapped);
  }

  final WorkoutCreateService workoutCreateService;
  final WorkoutsUserService userWorkoutsService;

  FutureOr<void> _copyTapped(CopyTapped event, emit) async {
    try {
      await workoutCreateService.setCopyWorkoutCreationData(event.workoutId);

      emit(NextCreateWorkoutPage());
    } catch (e, st) {
      emit(WorkoutErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  FutureOr<void> _changeTapped(ChangeTapped event, emit) async {
    try {
      await workoutCreateService.setChangeWorkoutCreationData(event.workoutId);

      emit(NextCreateWorkoutPage());
    } catch (e, st) {
      emit(WorkoutErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  FutureOr<void> _deleteTapped(DeleteTapped event, emit) async {
    try {
      await userWorkoutsService.deleteWorkoutById(event.workoutId);

      emit(NextWorkoutsPage());
    } catch (e, st) {
      emit(WorkoutErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
