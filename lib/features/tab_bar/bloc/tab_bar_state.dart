part of 'tab_bar_bloc.dart';

abstract class TabBarState extends Equatable {}

class TabBarInitial extends TabBarState {
  @override
  List<Object?> get props => [];
}

class TabBarItemSelectedState extends TabBarState {
  final int index;

  TabBarItemSelectedState({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
