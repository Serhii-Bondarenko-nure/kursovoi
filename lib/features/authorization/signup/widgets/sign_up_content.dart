import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/consts/path_constants.dart';
import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:authorization/features/authorization/signup/bloc/signup_bloc.dart';
import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/common_widgets/fitness_loading.dart';
import 'package:authorization/features/common_widgets/fitness_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConstants.white,
        child: Stack(
          children: [
            _createMainData(context),
            BlocBuilder<SignUpBloc, SignUpState>(
              buildWhen: (_, currState) =>
                  currState is LoadingState ||
                  currState is NextSetInitialUserParamPageState ||
                  currState is ErrorState,
              builder: (context, state) {
                if (state is LoadingState) {
                  return _createLoading();
                } else if (state is NextSetInitialUserParamPageState ||
                    state is ErrorState) {
                  return const SizedBox();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _createTitle(),
            // const SizedBox(height: 50),
            _createForm(context),
            const SizedBox(height: 20),
            _createSignUpButton(context),
            const SizedBox(height: 30),
            // _orContinueWith(),
            // const SizedBox(height: 25),
            _createHaveAccountText(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _createLoading() {
    return const FitnessLoading();
  }

  Widget _createTitle() {
    return const Text(
      TextConstants.signUp,
      style: TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);

    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          children: [
            FitnessTextField(
              title: TextConstants.username,
              placeholder: TextConstants.userNamePlaceholder,
              controller: bloc.userNameController,
              textInputAction: TextInputAction.next,
              errorText: TextConstants.usernameErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.username(bloc.userNameController.text)
                  : false,
              onTextChanged: () {
                bloc.add(TextChangedEvent());
              },
            ),
            _createSizeBox(bloc, state, 1),
            FitnessTextField(
              title: TextConstants.email,
              placeholder: TextConstants.emailPlaceholder,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: bloc.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              onTextChanged: () {
                bloc.add(TextChangedEvent());
              },
            ),
            _createSizeBox(bloc, state, 2),
            FitnessTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholder,
              obscureText: true,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              textInputAction: TextInputAction.next,
              controller: bloc.passwordController,
              errorText: TextConstants.passwordErrorText,
              onTextChanged: () {
                bloc.add(TextChangedEvent());
              },
            ),
            _createSizeBox(bloc, state, 3),
            FitnessTextField(
              title: TextConstants.confirmPassword,
              placeholder: TextConstants.confirmPasswordPlaceholder,
              obscureText: true,
              isError: state is ShowErrorState
                  ? !ValidationService.confirmPassword(
                      bloc.passwordController.text,
                      bloc.confirmPasswordController.text)
                  : false,
              controller: bloc.confirmPasswordController,
              errorText: TextConstants.confirmPasswordErrorText,
              onTextChanged: () {
                bloc.add(TextChangedEvent());
              },
            ),
            _createSizeBox(bloc, state, 4),
          ],
        );
      },
    );
  }

  Widget _createSizeBox(SignUpBloc bloc, SignUpState state, int fieldNum) {
    return state is ShowErrorState
        ? SizedBox(height: !_isSizeBoxe(bloc, fieldNum) ? 0 : 20)
        : const SizedBox(height: 20);
  }

  bool _isSizeBoxe(SignUpBloc bloc, int fieldNum) {
    switch (fieldNum) {
      //Username
      case 1:
        return ValidationService.username(bloc.userNameController.text);
      //Email
      case 2:
        return ValidationService.email(bloc.emailController.text);
      //Password
      case 3:
        return ValidationService.password(bloc.passwordController.text);
      //Confirm Password
      case 4:
        return ValidationService.confirmPassword(
          bloc.passwordController.text,
          bloc.confirmPasswordController.text,
        );
      default:
        return true;
    }
  }

  Widget _createSignUpButton(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (_, currState) =>
            currState is SignUpButtonEnableChangedState,
        builder: (context, state) {
          return FitnessButton(
            title: TextConstants.signUp,
            isEnabled: state is SignUpButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignUpTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _orContinueWith() {
    return SizedBox(
        child: Column(
      children: [
        const Text(
          TextConstants.orContinueWith,
          style: TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(PathConstants.facebook),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(PathConstants.instagram),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(PathConstants.twitter),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
            ),
          ],
        )
      ],
    ));
  }

  Widget _createHaveAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return RichText(
      text: TextSpan(
        text: TextConstants.alreadyHaveAccount,
        style: const TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: TextConstants.signIn,
            style: const TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                bloc.add(SignInTappedEvent());
              },
          ),
        ],
      ),
    );
  }
}
