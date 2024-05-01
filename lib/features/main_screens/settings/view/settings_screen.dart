import 'dart:io';

import 'package:authorization/core/constants/color_constants.dart';
import 'package:authorization/core/constants/path_constants.dart';
import 'package:authorization/core/constants/text_constants.dart';
import 'package:authorization/core/services/auth_service.dart';
import 'package:authorization/features/common_widgets/settings_container.dart';
import 'package:authorization/features/main_screens/settings/bloc/settings_bloc.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<SettingsBloc> _buildContext(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return _settingsContent(context);
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget _settingsContent(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "No Username";
    photoUrl = user?.photoURL;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(children: [
            Stack(alignment: Alignment.topRight, children: [
              Center(
                child: photoUrl == null
                    ? const CircleAvatar(
                        backgroundImage: AssetImage(PathConstants.profile),
                        radius: 60)
                    : CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                            child: FadeInImage.assetNetwork(
                          placeholder: PathConstants.profile,
                          image: photoUrl!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 120,
                        )),
                      ),
              ),
              TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const EditAccountRoute());
                    setState(() {
                      photoUrl = user?.photoURL;
                    });
                  },
                  style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor:
                          ColorConstants.primaryColor.withOpacity(0.16)),
                  child: const Icon(Icons.edit,
                      color: ColorConstants.primaryColor)),
            ]),
            const SizedBox(height: 15),
            Text(displayName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SettingsContainer(
              withArrow: true,
              onTap: () {
                AutoRouter.of(context).push(const ReminderRoute());
              },
              child: const Text(TextConstants.reminder,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            ),
            SettingsContainer(
              withArrow: true,
              onTap: () {
                AutoRouter.of(context)
                    .push(ExercisesSearchRoute(isWorkoutCreateScreen: false));
              },
              child: const Text("Exersices",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            ),
            if (!kIsWeb)
              SettingsContainer(
                child: Text(
                    '${TextConstants.rateUsOn}${Platform.isIOS ? 'App store' : 'Play market'}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500)),
                onTap: () async {
                  // launch(Platform.isIOS
                  //     ? 'https://www.apple.com/app-store/'
                  //     : 'https://play.google.com/store');

                  // final Uri url = Uri.parse(Platform.isIOS
                  //     ? 'https://www.apple.com/app-store/'
                  //     : 'https://play.google.com/store');
                  // if (!await launchUrl(url)) {
                  //   throw Exception('Could not launch $url');
                  // }
                },
              ),
            SettingsContainer(
                onTap: () => {},
                child: const Text(TextConstants.terms,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
            SettingsContainer(
                child: const Text(TextConstants.signOut,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                onTap: () {
                  AuthService.signOut();

                  AutoRouter.of(context).push(const SignInRoute());
                }),
            const SizedBox(height: 15),
            const Text(TextConstants.joinUs,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      //launch('https://www.facebook.com');
                    },
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: Image.asset(PathConstants.facebook)),
                TextButton(
                    onPressed: () {
                      //launch('https://www.instagram.com');
                    },
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: Image.asset(PathConstants.instagram)),
                TextButton(
                    onPressed: () {
                      //launch('https://twitter.com');
                    },
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        elevation: 1),
                    child: Image.asset(PathConstants.twitter)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
