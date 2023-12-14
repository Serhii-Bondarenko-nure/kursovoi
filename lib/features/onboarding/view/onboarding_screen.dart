import 'package:authorization/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:authorization/features/onboarding/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<OnboardingBloc> _buildBody(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (BuildContext context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (_, currState) => currState is NextScreenState,
        listener: (context, state) {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (_) {
          //       return SignUpScreen();
          //     },
          //   ),
          // );
          AutoRouter.of(context).pushAndPopUntil(const SignUpRoute(),
              predicate: (route) => false);
        },
        buildWhen: (_, currState) => currState is OnboardingInitial,
        builder: (context, state) {
          return const OnboardingContent();
        },
      ),
    );
  }
}
