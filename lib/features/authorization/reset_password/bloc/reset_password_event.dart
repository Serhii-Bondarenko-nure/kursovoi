part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {}

class ResetPasswordTappedEvent extends ResetPasswordEvent {
  @override
  List<Object?> get props => [];
}
