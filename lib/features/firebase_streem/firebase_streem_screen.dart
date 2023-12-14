import 'package:authorization/features/onboarding/view/onboarding_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authorization/features/tab_bar/view/tab_bar_screen.dart';

@RoutePage()
class FirebaseStreamScreen extends StatelessWidget {
  const FirebaseStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Что-то пошло не так!')));
        } else if (snapshot.hasData) {
          // if (!snapshot.data!.emailVerified) {
          //   return const VerifyEmailScreen();
          // }
          return const TabBarScreen(transitionIndex: 0);
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
