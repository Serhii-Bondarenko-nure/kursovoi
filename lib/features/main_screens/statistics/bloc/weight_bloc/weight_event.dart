part of 'weight_bloc.dart';

abstract class WeightEvent extends Equatable {}

class LoadWeightData extends WeightEvent {
  @override
  List<Object?> get props => [];
}

class WeightHeightChangeTapped extends WeightEvent {
  WeightHeightChangeTapped({
    required this.weight,
    required this.height,
  });

  final double weight;
  final int height;

  @override
  List<Object?> get props => [weight, height];
}

class AddWeightByDateTapped extends WeightEvent {
  AddWeightByDateTapped({
    required this.weight,
    required this.date,
  });

  final double weight;
  final DateTime date;

  @override
  List<Object?> get props => [weight, date];
}
