import 'package:authorization/features/authorization/signin/bloc/signin_bloc.dart';
import 'package:authorization/features/authorization/signin/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<SignInBloc> _buildContext(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (BuildContext context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (_, currState) =>
            currState is NextResetPasswordPageState ||
            currState is NextSignUpPageState ||
            currState is NextTabBarPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextResetPasswordPageState) {
            //AutoRouter.of(context).push(const ResetPasswordRoute());
            AutoRouter.of(context).pushAndPopUntil(const ResetPasswordRoute(),
                predicate: (route) => false);
          } else if (state is NextSignUpPageState) {
            AutoRouter.of(context).pushAndPopUntil(const SignUpRoute(),
                predicate: (route) => false);
          } else if (state is NextTabBarPageState) {
            AutoRouter.of(context).pushAndPopUntil(
                TabBarRoute(transitionIndex: 0),
                predicate: (route) => false);
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is SignInInitial,
        builder: (context, state) {
          return const SignInContent();
        },
      ),
    );
  }
}
