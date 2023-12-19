import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/core/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePassword>((event, emit) async {
      emit(ChangePasswordProgress());
      try {
        await UserService.changePassword(newPass: event.newPass);
        emit(ChangePasswordSuccess(message: TextConstants.passwordUpdated));
        await Future.delayed(const Duration(seconds: 1));
        emit(ChangePasswordInitial());
      } catch (e, st) {
        emit(ChangePasswordError(e.toString()));
        await Future.delayed(const Duration(seconds: 1));
        emit(ChangePasswordInitial());

        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
