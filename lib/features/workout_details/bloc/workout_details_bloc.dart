import 'dart:async';

import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:authorization/core/services/workouts_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'workout_details_event.dart';
part 'workout_details_state.dart';

class WorkoutDetailsBloc
    extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  WorkoutDetailsBloc({
    required this.workoutsService,
    required this.exersicesRepository,
    required this.userWorkoutsService,
  }) : super(WorkoutDetailsInitial()) {
    on<LoadWorkoutDetailsEvent>(_load);
    on<AddWorkoutTapped>((event, emit) async {
      await userWorkoutsService.updateWorkoutById(event.workout);
      emit(NextWorkoutsPage());
    });
    on<StartWorkoutTapped>((event, emit) =>
        emit(NextWorkoutPerformingPage(workout: event.workout)));
    on<RepeatWorkoutTapped>((event, emit) async {
      await userWorkoutsService.updateWorkoutIsCompleteFieldById(
          event.workout.id, false);
      emit(NextWorkoutPerformingPage(workout: event.workout));
    });
    on<ExerciseDetailsTapped>((event, emit) {
      emit(NextExerciseDetailsPage(exerciseId: event.exerciseId));
    });
    on<WorkoutSettingsTapped>((event, emit) async {
      emit(ShowWorkoutSettingsPage(
        workoutId: event.workoutId,
        isUserOwner: event.isUserOwner,
        isSearchScreen: event.isSearchScreen,
      ));
    });
  }

  final WorkoutsService workoutsService;
  final AbstractExersicesRepository exersicesRepository;
  final WorkoutsUserService userWorkoutsService;

  FutureOr<void> _load(
      LoadWorkoutDetailsEvent event, Emitter<WorkoutDetailsState> emit) async {
    try {
      if (state is! WorkoutDetailsLoaded) {
        emit(WorkoutDetailsLoading());
      }

      final workout = event.isSearchScreen
          ? await workoutsService.getWorkoutById(event.workoutId)
          : await userWorkoutsService.getWorkoutById(event.workoutId);

      var exercisesGifUrl = <String>[];
      for (var exercise in workout.exercises.values) {
        final exerciseGifUrl = await exersicesRepository
            .getExerciseById(exercise.id)
            .then((exercise) => exercise.gifUrl);
        exercisesGifUrl.add(exerciseGifUrl);
      }

      emit(WorkoutDetailsLoaded(
        workout: workout,
        exercisesGifUrl: exercisesGifUrl,
      ));
    } catch (e, st) {
      emit(WorkoutDetailsErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
