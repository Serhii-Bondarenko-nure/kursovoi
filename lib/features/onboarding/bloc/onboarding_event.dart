part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {}

class PageChangedEvent extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}

class PageSwipedEvent extends OnboardingEvent {
  final int index;

  PageSwipedEvent({required this.index});
  @override
  List<Object?> get props => [index];
}
