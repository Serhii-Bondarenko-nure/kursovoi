import 'package:authorization/core/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final emailController = TextEditingController();
  bool isError = false;

  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordTappedEvent>(
      (event, emit) async {
        try {
          emit(ResetPasswordLoading());
          await AuthService.resetPassword(emailController.text);
          emit(ResetPasswordSuccess());
        } catch (e, st) {
          TalkerLog('Error: $e');
          emit(ResetPasswordError(message: e.toString()));
          GetIt.I<Talker>().handle(e, st);
        }
      },
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
