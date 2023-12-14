import 'dart:async';

import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_card_event.dart';
part 'workout_card_state.dart';

class WorkoutCardBloc extends Bloc<WorkoutCardEvent, WorkoutCardState> {
  WorkoutCardBloc({required this.workoutsRepository})
      : super(WorkoutCardInitial()) {
    on<LoadWorkoutsListByType>(_loadWorkoutsListByType);
    on<CollapsedWorkoutsList>((event, emit) {
      isCollapsed = !isCollapsed;
      emit(WorkoutsListByTypeIsCollapsed());
    });
  }

  final AbstractWorkoutsRepository workoutsRepository;

  bool isCollapsed = true;

  FutureOr<void> _loadWorkoutsListByType(
      LoadWorkoutsListByType event, Emitter<WorkoutCardState> emit) async {
    try {
      if (state is! WorkoutsListByTypeLoaded) {
        emit(WorkoutsListByTypeLoading());
      }

      final workoutsListByType =
          await workoutsRepository.getWorkoutsListByType(event.workoutType);
      emit(WorkoutsListByTypeLoaded(workoutsListByType: workoutsListByType));
    } catch (e, st) {
      emit(WorkoutCardErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
