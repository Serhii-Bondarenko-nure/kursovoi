import 'package:authorization/core/constants/color_constants.dart';
import 'package:authorization/core/constants/text_constants.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:authorization/features/authorization/signin/bloc/signin_bloc.dart';
import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/common_widgets/fitness_loading.dart';
import 'package:authorization/features/common_widgets/fitness_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<SignInBloc, SignInState>(
            buildWhen: (_, currState) =>
                currState is LoadingState ||
                currState is ErrorState ||
                currState is NextTabBarPageState,
            builder: (context, state) {
              if (state is LoadingState) {
                return _createLoading();
              } else if (state is ErrorState || state is NextTabBarPageState) {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _createHeader(),
              const SizedBox(height: 50),
              _createForm(context),
              //const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 40),
              _createSignInButton(context),
              const Spacer(),
              _createDoNotHaveAccountText(context),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createLoading() {
    return const FitnessLoading();
  }

  Widget _createHeader() {
    return const Center(
      child: Text(
        TextConstants.signIn,
        style: TextStyle(
          color: ColorConstants.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FitnessTextField(
              title: TextConstants.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              placeholder: TextConstants.emailPlaceholder,
              controller: bloc.emailController,
              errorText: TextConstants.emailErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              onTextChanged: () {
                bloc.add(TextChangeEvent());
              },
            ),
            _createSizeBox(bloc, state, 1),
            FitnessTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholder,
              controller: bloc.passwordController,
              errorText: TextConstants.passwordErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              obscureText: true,
              onTextChanged: () {
                bloc.add(TextChangeEvent());
              },
            ),
            _createSizeBox(bloc, state, 2),
          ],
        );
      },
    );
  }

  Widget _createSizeBox(SignInBloc bloc, SignInState state, int fieldNum) {
    return state is ShowErrorState
        ? SizedBox(height: !_isSizeBoxe(bloc, fieldNum) ? 0 : 20)
        : const SizedBox(height: 20);
  }

  bool _isSizeBoxe(SignInBloc bloc, int fieldNum) {
    switch (fieldNum) {
      //Email
      case 1:
        return ValidationService.email(bloc.emailController.text);
      //Password
      case 2:
        return ValidationService.password(bloc.passwordController.text);
      default:
        return true;
    }
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(left: 21),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryColor,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        bloc.add(ResetPasswordTappedEvent());
      },
    );
  }

  Widget _createSignInButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (_, currState) =>
            currState is SignInButtonEnableChangedState,
        builder: (context, state) {
          return FitnessButton(
            title: TextConstants.signIn,
            isEnabled: state is SignInButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignInTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _createDoNotHaveAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: TextConstants.signUp,
              style: const TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  bloc.add(SignUpTappedEvent());
                },
            ),
          ],
        ),
      ),
    );
  }
}
