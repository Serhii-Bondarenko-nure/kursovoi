import 'dart:async';

import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_history_event.dart';
part 'workout_history_state.dart';

class WorkoutsHistoryBloc
    extends Bloc<WorkoutsHistoryEvent, WorkoutsHistoryState> {
  WorkoutsHistoryBloc({
    required this.workoutPerformingService,
  }) : super(WorkoutsHistoryInitial()) {
    on<LoadWorkoutsHistory>(_load);
  }

  final WorkoutPerformingService workoutPerformingService;

  FutureOr<void> _load(
      LoadWorkoutsHistory event, Emitter<WorkoutsHistoryState> emit) async {
    try {
      if (state is! WorkoutsHistoryLoaded) {
        emit(WorkoutsHistoryLoading());
      }

      final workouts = await workoutPerformingService.getWorkoutHistoryData();

      emit(WorkoutsHistoryLoaded(workouts: workouts));
    } catch (e, st) {
      emit(WorkoutsHistoryErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
