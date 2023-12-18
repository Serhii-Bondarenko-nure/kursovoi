import 'dart:async';

import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc({required this.userWorkoutsService}) : super(WorkoutInitial()) {
    on<LoadWorkoutsList>(_load);
    on<WorkoutDetailsTapped>((event, emit) =>
        emit(NextWorkoutDetailsPage(workoutId: event.workoutId)));
    on<WorkoutCreateTapped>((event, emit) async {
      await GetIt.I<WorkoutCreateService>().setSimpleWorkoutCreationData();
      emit(NextCreateWorkoutPage());
    });
    on<StopWorkoutTapped>((event, emit) async {
      await GetIt.I<WorkoutPerformingService>()
          .updateIsTrainingInProgress(false);
      emit(NextReloadedState());
    });
  }

  final WorkoutsUserService userWorkoutsService;

  bool isTrainingInProgress = false;

  FutureOr<void> _load(
      LoadWorkoutsList event, Emitter<WorkoutState> emit) async {
    try {
      if (state is! WorkoutsListLoaded) {
        emit(WorkoutsListLoading());
      }

      isTrainingInProgress =
          await GetIt.I<WorkoutPerformingService>().getIsTrainingInProgress();

      final workoutsList = await userWorkoutsService.getWorkoutsList();
      emit(WorkoutsListLoaded(workoutsList: workoutsList));
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
