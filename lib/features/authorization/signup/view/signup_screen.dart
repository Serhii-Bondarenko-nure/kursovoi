import 'package:authorization/features/authorization/signup/bloc/signup_bloc.dart';
import 'package:authorization/features/authorization/signup/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SignUpBloc> _buildBody(context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (_, currState) =>
            currState is NextSetInitialUserParamPageState ||
            currState is NextSignInPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextSetInitialUserParamPageState) {
            AutoRouter.of(context).pushAndPopUntil(SetInitialUserParamRoute(),
                predicate: (route) => false);
            // AutoRouter.of(context).pushAndPopUntil(
            //     TabBarRoute(transitionIndex: 0),
            //     predicate: (route) => false);
          } else if (state is NextSignInPageState) {
            AutoRouter.of(context).pushAndPopUntil(const SignInRoute(),
                predicate: (route) => false);
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is SignUpInitial,
        builder: (context, state) {
          return const SignUpContent();
        },
      ),
    );
  }
}
