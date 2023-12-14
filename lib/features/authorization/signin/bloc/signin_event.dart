part of 'signin_bloc.dart';

abstract class SignInEvent extends Equatable {}

class TextChangeEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignInTappedEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class SignUpTappedEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class ResetPasswordTappedEvent extends SignInEvent {
  @override
  List<Object?> get props => [];
}
