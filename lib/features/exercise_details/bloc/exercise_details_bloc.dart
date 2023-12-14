import 'dart:async';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/exercises/models/exercise.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'exercise_details_event.dart';
part 'exercise_details_state.dart';

class ExerciseDetailsBloc
    extends Bloc<ExerciseDetailsEvent, ExerciseDetailsState> {
  ExerciseDetailsBloc({required this.exersicesRepository})
      : super(ExerciseDetailsInitial()) {
    on<LoadExerciseDetailsEvent>(_load);
  }

  final AbstractExersicesRepository exersicesRepository;

  FutureOr<void> _load(LoadExerciseDetailsEvent event, emit) async {
    try {
      if (state is! ExerciseDetailsLoaded) {
        emit(ExerciseDetailsLoading());
      }

      final exercise = await exersicesRepository.getExerciseById(event.id);
      emit(ExerciseDetailsLoaded(exercise: exercise));
    } catch (e, st) {
      emit(ExerciseDetailsErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
