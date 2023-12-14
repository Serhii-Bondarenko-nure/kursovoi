import 'dart:async';
import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'exercises_search_event.dart';
part 'exercises_search_state.dart';

class ExercisesSearchBloc
    extends Bloc<ExercisesSearchEvent, ExercisesSearchState> {
  ExercisesSearchBloc({required this.exersicesRepository})
      : super(ExercisesSearchInitial()) {
    on<LoadExercisesList>(_load);
    on<ExerciseDetailsTapped>((event, emit) {
      emit(NextExerciseDetailsPage(exerciseId: event.exerciseId));
    });
    on<WorkoutCreateTapped>((event, emit) {
      emit(NextWorkoutCreatePage(exercise: event.exercise));
    });
  }

  final AbstractExersicesRepository exersicesRepository;

  FutureOr<void> _load(event, emit) async {
    try {
      if (state is! ExercisesListLoaded) {
        emit(ExercisesListLoading());
      }

      final exercisesList = await exersicesRepository.getExercisesList();
      emit(ExercisesListLoaded(exercisesList: exercisesList));
    } catch (e, st) {
      emit(ErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
