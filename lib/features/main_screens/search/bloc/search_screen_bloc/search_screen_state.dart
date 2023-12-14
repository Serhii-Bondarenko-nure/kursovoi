part of 'search_screen_bloc.dart';

abstract class SearchScreenState extends Equatable {}

class SearchInitial extends SearchScreenState {
  @override
  List<Object?> get props => [];
}

class TypesListLoading extends SearchScreenState {
  @override
  List<Object?> get props => [];
}

class TypesListLoaded extends SearchScreenState {
  TypesListLoaded({required this.types});

  final Types types;

  @override
  List<Object?> get props => [types];
}

class NextWorkoutDetailsPage extends SearchScreenState {
  NextWorkoutDetailsPage({
    required this.workoutId,
  });

  final int workoutId;

  @override
  List<Object?> get props => [workoutId];
}

class SearchErrorState extends SearchScreenState {
  SearchErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
