import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/services/validation_service.dart';
import 'package:authorization/features/authorization/reset_password/bloc/reset_password_bloc.dart';
import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/common_widgets/fitness_loading.dart';
import 'package:authorization/features/common_widgets/fitness_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordContent extends StatefulWidget {
  const ResetPasswordContent({super.key});

  @override
  State<ResetPasswordContent> createState() => _ResetPasswordContentState();
}

class _ResetPasswordContentState extends State<ResetPasswordContent> {
  bool _isButtonEnabled = false;
  bool _isTextFieldError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
            buildWhen: (_, currState) =>
                currState is ResetPasswordLoading ||
                currState is ResetPasswordError ||
                currState is ResetPasswordSuccess,
            builder: (context, state) {
              if (state is ResetPasswordLoading) {
                return _createLoading();
              } else if (state is ResetPasswordSuccess) {
                return const SizedBox();
              } else if (state is ResetPasswordError) {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createLoading() {
    return const FitnessLoading();
  }

  Widget _createMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height -
              30 -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight,
          child: Column(
            children: [
              const Spacer(flex: 2),
              _createForm(context),
              const Spacer(flex: 3),
              _createResetPasswordButton(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<ResetPasswordBloc>(context);
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return FitnessTextField(
          title: "Email",
          keyboardType: TextInputType.emailAddress,
          placeholder: "example@mail.com",
          controller: bloc.emailController,
          errorText: 'Email is unvalid, please enter email properly',
          isError: _isTextFieldError,
          onTextChanged: () {
            setState(() {
              _isButtonEnabled = bloc.emailController.text.isNotEmpty;
            });
          },
        );
      },
    );
  }

  Widget _createResetPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<ResetPasswordBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          return FitnessButton(
            title: 'Send Activation Link',
            isEnabled: _isButtonEnabled,
            onTap: () {
              FocusScope.of(context).unfocus();
              if (_isButtonEnabled) {
                setState(() {
                  _isTextFieldError =
                      !ValidationService.email(bloc.emailController.text);
                });
                if (!_isTextFieldError) {
                  bloc.add(ResetPasswordTappedEvent());
                }
              }
            },
          );
        },
      ),
    );
  }
}
