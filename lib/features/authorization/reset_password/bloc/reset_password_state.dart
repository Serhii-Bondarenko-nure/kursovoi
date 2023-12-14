part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {}

class ResetPasswordInitial extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  ResetPasswordError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccess extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}
