part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {}

class OnboardingInitial extends OnboardingState {
  @override
  List<Object?> get props => [];
}

class PageChangedState extends OnboardingState {
  final int counter;

  PageChangedState({
    required this.counter,
  });
  @override
  List<Object?> get props => [counter];
}

class NextScreenState extends OnboardingState {
  @override
  List<Object?> get props => [];
}
