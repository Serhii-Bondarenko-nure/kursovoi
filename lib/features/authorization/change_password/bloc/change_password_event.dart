part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {}

class ChangePassword extends ChangePasswordEvent {
  final String newPass;
  ChangePassword({required this.newPass});

  @override
  List<Object?> get props => [newPass];
}
