import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int pageIndex = 0;
  final pageController = PageController(initialPage: 0);

  OnboardingBloc() : super(OnboardingInitial()) {
    on<PageChangedEvent>((event, emit) {
      if (pageIndex == 2) {
        emit(NextScreenState());
        return;
      }
      pageIndex += 1;

      pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      emit(PageChangedState(counter: pageIndex));
    });
    on<PageSwipedEvent>((event, emit) {
      pageIndex = event.index;
      emit(PageChangedState(counter: pageIndex));
    });
  }

  //GetIt.I<Talker>().handle(e, st);

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
