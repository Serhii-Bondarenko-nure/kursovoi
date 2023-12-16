import 'dart:async';

import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:authorization/core/services/workouts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc({required this.workoutsService}) : super(SearchInitial()) {
    on<LoadTypesList>(_loadTypesList);
    on<WorkoutDetailsTapped>((event, emit) => emit(NextWorkoutDetailsPage(
          workoutId: event.workoutId,
        )));
  }

  final WorkoutsService workoutsService;

  FutureOr<void> _loadTypesList(
      LoadTypesList event, Emitter<SearchScreenState> emit) async {
    try {
      if (state is! TypesListLoaded) {
        emit(TypesListLoading());
      }

      final types = await workoutsService.getTypesList();
      emit(TypesListLoaded(types: types));
    } catch (e, st) {
      emit(SearchErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
