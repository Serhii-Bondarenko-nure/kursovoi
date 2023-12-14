part of 'tab_bar_bloc.dart';

abstract class TabBarEvent extends Equatable {}

class TabBarItemTappedEvent extends TabBarEvent {
  final int index;

  TabBarItemTappedEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
