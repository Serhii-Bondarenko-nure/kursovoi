part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {}

class SignInInitial extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInButtonEnableChangedState extends SignInState {
  final bool isEnabled;

  SignInButtonEnableChangedState({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [isEnabled];
}

class ShowErrorState extends SignInState {
  @override
  List<Object?> get props => [];
}

class NextResetPasswordPageState extends SignInState {
  @override
  List<Object?> get props => [];
}

class NextSignUpPageState extends SignInState {
  @override
  List<Object?> get props => [];
}

class NextTabBarPageState extends SignInState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends SignInState {
  final String message;

  ErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class LoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}
