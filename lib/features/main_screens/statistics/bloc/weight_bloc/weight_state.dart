part of 'weight_bloc.dart';

abstract class WeightState extends Equatable {}

class WeightInitial extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightDataLoading extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightDataLoaded extends WeightState {
  WeightDataLoaded(
      {required this.bmi,
      required this.weight,
      required this.height,
      required this.minWeight,
      required this.maxWeight,
      required this.weightsMap});

  final double bmi;
  final double weight;
  final int height;
  final double minWeight;
  final double maxWeight;
  final Map<DateTime, double> weightsMap;

  @override
  List<Object?> get props => [
        bmi,
        weight,
        height,
        minWeight,
        maxWeight,
        weightsMap,
      ];
}

class NextReloadedState extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightErrorState extends WeightState {
  WeightErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
