import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  int currentIndex;

  TabBarBloc({required this.currentIndex}) : super(TabBarInitial()) {
    on<TabBarItemTappedEvent>((event, emit) {
      currentIndex = event.index;
      emit(TabBarItemSelectedState(index: currentIndex));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
