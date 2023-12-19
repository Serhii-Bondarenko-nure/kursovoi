part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordProgress extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordError extends ChangePasswordState {
  ChangePasswordError(this.error);

  final String error;
  @override
  List<Object?> get props => [error];
}

class ChangePasswordSuccess extends ChangePasswordState {
  ChangePasswordSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
