import 'dart:async';

import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'exercise_card_event.dart';
part 'exercise_card_state.dart';

class ExerciseCardBloc extends Bloc<ExerciseCardEvent, ExerciseCardState> {
  ExerciseCardBloc({
    required this.workoutPerformingService,
  }) : super(ExerciseCardInitial()) {
    on<LoadExerciseCard>(_load);
    on<ExerciseSetTapped>((event, emit) async {
      await workoutPerformingService
          .updateExerciseFlagByExerciseNumberAndSetNumber(
              event.exerciseNumber, event.setNumber, event.flag);
      emit(NextReloadExerciseCard());
    });
  }

  final WorkoutPerformingService workoutPerformingService;

  FutureOr<void> _load(
      LoadExerciseCard event, Emitter<ExerciseCardState> emit) async {
    try {
      if (state is! ExerciseCardLoaded) {
        emit(ExerciseCardLoading());
      }

      final flags = await workoutPerformingService
          .getExerciseFlagsByExerciseNumber(event.exerciseNumber);

      emit(ExerciseCardLoaded(flags: flags));
    } catch (e, st) {
      emit(ExerciseCardErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
