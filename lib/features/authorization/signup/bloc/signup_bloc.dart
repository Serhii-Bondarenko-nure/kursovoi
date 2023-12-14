import 'package:authorization/core/services/auth_service.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  SignUpBloc() : super(SignUpInitial()) {
    on<TextChangedEvent>((event, emit) {
      if (isButtonEnabled != checkIfSignUpButtonEnabled()) {
        isButtonEnabled = checkIfSignUpButtonEnabled();
        emit(SignUpButtonEnableChangedState(isEnabled: isButtonEnabled));
      }
    });
    on<SignUpTappedEvent>((event, emit) async {
      try {
        if (checkValidatorsOfTextField()) {
          emit(LoadingState());
          await AuthService.signUp(emailController.text,
              passwordController.text, userNameController.text);
          emit(NextTabBarPageState());
          TalkerLog("Go to the next page");
        } else {
          TalkerLog("Validation Error");
          emit(ShowErrorState());
        }
      } catch (e, st) {
        emit(ErrorState(message: e.toString()));
        GetIt.I<Talker>().handle(e, st);
      }
    });
    on<SignInTappedEvent>((event, emit) => emit(NextSignInPageState()));
  }

  bool checkIfSignUpButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.username(userNameController.text) &&
        ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text) &&
        ValidationService.confirmPassword(
            passwordController.text, confirmPasswordController.text);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
