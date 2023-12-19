part of 'edit_account_bloc.dart';

abstract class EditAccountState extends Equatable {}

class EditAccountInitial extends EditAccountState {
  @override
  List<Object?> get props => [];
}

class EditAccountProgress extends EditAccountState {
  @override
  List<Object?> get props => [];
}

class EditAccountError extends EditAccountState {
  EditAccountError(this.error, {required Object exeption});

  final String error;

  @override
  List<Object?> get props => [error];
}

class EditPhotoSuccess extends EditAccountState {
  EditPhotoSuccess(this.image);

  final XFile image;

  @override
  List<Object?> get props => [image];
}
