import 'package:authorization/core/constants/color_constants.dart';
import 'package:authorization/features/authorization/reset_password/bloc/reset_password_bloc.dart';
import 'package:authorization/features/authorization/reset_password/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Password Reset',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () =>
                //AutoRouter.of(context).pop(),
                AutoRouter.of(context).pushAndPopUntil(const SignInRoute(),
                    predicate: (route) => false),
          ),
          iconTheme: const IconThemeData(
            color: ColorConstants.primaryColor,
          )),
      body: _buildContext(context),
    );
  }

  BlocProvider<ResetPasswordBloc> _buildContext(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (BuildContext context) => ResetPasswordBloc(),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listenWhen: (_, currState) =>
            currState is ResetPasswordError ||
            currState is ResetPasswordSuccess,
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            forgotPasswordSuccessfullySended(context);
            //AutoRouter.of(context).pop();
            AutoRouter.of(context).pushAndPopUntil(const SignInRoute(),
                predicate: (route) => false);
          }
          if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is ResetPasswordInitial,
        builder: (context, state) {
          return const ResetPasswordContent();
        },
      ),
    );
  }

  Future<void> forgotPasswordSuccessfullySended(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Reset password link was sent on your email.'),
        duration: Duration(seconds: 2)));
    await Future.delayed(const Duration(seconds: 2));
  }
}
