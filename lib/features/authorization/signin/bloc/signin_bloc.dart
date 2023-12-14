import 'package:authorization/core/services/auth_service.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;
  SignInBloc() : super(SignInInitial()) {
    on<TextChangeEvent>((event, emit) {
      if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
        isButtonEnabled = _checkIfSignInButtonEnabled();
        emit(SignInButtonEnableChangedState(isEnabled: isButtonEnabled));
      }
    });
    on<SignInTappedEvent>((event, emit) async {
      if (_checkValidatorsOfTextField()) {
        try {
          emit(LoadingState());
          await AuthService.signIn(
              emailController.text, passwordController.text);
          emit(NextTabBarPageState());
          TalkerLog("Go to the next page");
        } catch (e, st) {
          TalkerLog('E to tstrng: $e');
          emit(ErrorState(message: e.toString()));
          GetIt.I<Talker>().handle(e, st);
        }
      } else {
        emit(ShowErrorState());
      }
    });
    on<SignUpTappedEvent>((event, emit) => emit(NextSignUpPageState()));
    on<ResetPasswordTappedEvent>(
        (event, emit) => emit(NextResetPasswordPageState()));
  }

  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
