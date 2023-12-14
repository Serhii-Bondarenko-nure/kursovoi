part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpButtonEnableChangedState extends SignUpState {
  final bool isEnabled;

  SignUpButtonEnableChangedState({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [isEnabled];
}

class ShowErrorState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends SignUpState {
  final String message;

  ErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class NextTabBarPageState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class NextSignInPageState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}
