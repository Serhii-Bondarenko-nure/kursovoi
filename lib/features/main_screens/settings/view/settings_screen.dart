import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    AutoRouter.of(context).push(const SignUpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.settingsIcon)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Open shopping cart',
            onPressed: () => signOut(),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ваш Email: ${user?.email}'),
            Text('Ваше имя: ${user?.displayName}'),
            TextButton(
              onPressed: () => signOut(),
              child: const Text('Выйти'),
            ),
            TextButton(
              onPressed: () {
                AutoRouter.of(context)
                    .push(ExercisesSearchRoute(isWorkoutCreateScreen: false));
              },
              child: const Text('Упражнения'),
            ),
          ],
        ),
      ),
    );
  }
}
