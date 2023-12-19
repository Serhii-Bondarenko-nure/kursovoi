import 'dart:async';

import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  WeightBloc({required this.statisticsWeightServise}) : super(WeightInitial()) {
    on<LoadWeightData>(_load);
    on<WeightHeightChangeTapped>((event, emit) async {
      await statisticsWeightServise.setWeight(event.weight);
      await statisticsWeightServise.setHeight(event.height);

      emit(NextReloadedState());
    });
    on<AddWeightByDateTapped>((event, emit) async {
      await statisticsWeightServise.setWeightByDate(event.weight, event.date);

      emit(NextReloadedState());
    });
  }

  final StatisticsWeightServise statisticsWeightServise;

  FutureOr<void> _load(LoadWeightData event, Emitter<WeightState> emit) async {
    try {
      if (state is! WeightDataLoaded) {
        emit(WeightDataLoading());
      }

      final bmi = await statisticsWeightServise.getBMI();
      final weight = await statisticsWeightServise.getWeight();
      final height = await statisticsWeightServise.getHeight();
      final minWeight = await statisticsWeightServise.getMinWeight();
      final maxWeight = await statisticsWeightServise.getMaxWeight();
      final weightsMap = await statisticsWeightServise.getWeightsForGraph();

      emit(WeightDataLoaded(
          bmi: bmi,
          weight: weight,
          height: height,
          minWeight: minWeight,
          maxWeight: maxWeight,
          weightsMap: weightsMap));
    } catch (e, st) {
      emit(WeightErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
