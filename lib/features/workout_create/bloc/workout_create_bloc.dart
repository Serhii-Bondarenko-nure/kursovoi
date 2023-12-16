import 'dart:async';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_create_event.dart';
part 'workout_create_state.dart';

class WorkoutCreateBloc extends Bloc<WorkoutCreateEvent, WorkoutCreateState> {
  WorkoutCreateBloc({
    required this.workoutCreateService,
    required this.exersicesRepository,
  }) : super(WorkoutCreateInitial()) {
    on<LoadWorkoutCreateData>(_load);
    on<AddExerciseTapped>((event, emit) {
      //метод перестановки порядка упражнений
      emit(NextExercisesSearchPage(isWorkoutCreateScreen: true));
    });
    on<DeleteExerciseTapped>((event, emit) async {
      await workoutCreateService.deleteExerciseData(event.exercisesNumber);
      //метод перестановки порядка упражнений
      emit(ExerciseDeleted());
    });
    on<SaveWorkoutTapped>((event, emit) {
      //метод перестановки порядка упражнений
      emit(NextWorkoutsPage());
    });
  }

  final WorkoutCreateService workoutCreateService;
  final AbstractExersicesRepository exersicesRepository;

  Map<int, int> exercisesPositionChange = {};

  FutureOr<void> _load(
      LoadWorkoutCreateData event, Emitter<WorkoutCreateState> emit) async {
    try {
      if (state is! WorkoutCreateDataLoaded) {
        emit(WorkoutCreateDataLoading());
      }

      final workout = await workoutCreateService.getWorkoutCreationData();

      var exercisesGifUrl = <String>[];
      for (var exercise in workout.exercises.values) {
        final exerciseGifUrl = await exersicesRepository
            .getExerciseById(exercise.id)
            .then((exercise) => exercise.gifUrl);
        exercisesGifUrl.add(exerciseGifUrl);
      }

      for (var i = 0; i < workout.exercises.length; i++) {
        exercisesPositionChange.update(i, (value) => i);
      }

      emit(WorkoutCreateDataLoaded(
        workout: workout,
        exercisesGifUrl: exercisesGifUrl,
      ));
    } catch (e, st) {
      emit(WorkoutCreateDataErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
