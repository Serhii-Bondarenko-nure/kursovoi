part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {}

class TextChangedEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class SignUpTappedEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class SignInTappedEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
