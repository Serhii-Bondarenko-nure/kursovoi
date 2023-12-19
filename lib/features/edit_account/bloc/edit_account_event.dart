part of 'edit_account_bloc.dart';

abstract class EditAccountEvent extends Equatable {}

class UploadImage extends EditAccountEvent {
  @override
  List<Object?> get props => [];
}

class ChangeUserData extends EditAccountEvent {
  ChangeUserData({required this.displayName, required this.email});

  final String displayName;
  final String email;

  @override
  List<Object?> get props => [
        displayName,
        email,
      ];
}
