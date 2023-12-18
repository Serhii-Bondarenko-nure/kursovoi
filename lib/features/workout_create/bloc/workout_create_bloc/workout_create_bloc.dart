import 'dart:async';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
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
      emit(NextExercisesSearchPage(isWorkoutCreateScreen: true));
    });
    on<DeleteExerciseTapped>((event, emit) async {
      await workoutCreateService.deleteExerciseData(event.exercisesNumber);
      emit(ExerciseDeleted());
    });
    on<SaveWorkoutTapped>((event, emit) async {
      await workoutCreateService.saveNewWorkout();
      emit(NextWorkoutsPage());
    });
  }

  final WorkoutCreateService workoutCreateService;
  final AbstractExersicesRepository exersicesRepository;

  final workoutNameController = TextEditingController();

  int exercisesLengs = 0;

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

      workoutNameController.text = workout.name;

      exercisesLengs = workout.exercises.length;

      emit(WorkoutCreateDataLoaded(
        workout: workout,
        exercisesGifUrl: exercisesGifUrl,
      ));
    } catch (e, st) {
      emit(WorkoutCreateErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
