import 'dart:async';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_performing_event.dart';
part 'workout_performing_state.dart';

class WorkoutPerformingBloc
    extends Bloc<WorkoutPerformingEvent, WorkoutPerformingState> {
  WorkoutPerformingBloc({
    required this.workoutPerformingService,
    required this.exersicesRepository,
  }) : super(WorkoutPerformingInitial()) {
    on<LoadWorkoutPerformingData>(_load);
    on<ExerciseDetailsTapped>((event, emit) {
      emit(NextExerciseDetailsPage(exerciseId: event.exerciseId));
    });
    on<WorkoutCompleteTapped>((event, emit) async {
      await workoutPerformingService.updateIsTrainingInProgress(false);
      await workoutPerformingService
          .updateLastCompleteInUserWorkouts(event.workoutId);
      await workoutPerformingService.updateLastCompleteInWorkoutPerforming();

      //Ну и метод сохранения данных в статистику

      emit(NextStaticticsPage());
    });
  }

  final WorkoutPerformingService workoutPerformingService;
  final AbstractExersicesRepository exersicesRepository;

  FutureOr<void> _load(LoadWorkoutPerformingData event,
      Emitter<WorkoutPerformingState> emit) async {
    try {
      if (state is! WorkoutPerformingDataLoaded) {
        emit(WorkoutPerformingDataLoading());
      }

      final workout = await workoutPerformingService.getWorkoutPerformingData();

      var exercisesGifUrl = <String>[];
      for (var exercise in workout.exercises.values) {
        final exerciseGifUrl = await exersicesRepository
            .getExerciseById(exercise.id)
            .then((exercise) => exercise.gifUrl);
        exercisesGifUrl.add(exerciseGifUrl);
      }

      emit(WorkoutPerformingDataLoaded(
        workout: workout,
        exercisesGifUrl: exercisesGifUrl,
      ));
    } catch (e, st) {
      emit(WorkoutPerformingErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
