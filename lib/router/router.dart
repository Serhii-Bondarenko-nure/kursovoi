import 'package:authorization/features/authorization/authorization.dart';
import 'package:authorization/features/exercise_details/exercise_details.dart';
import 'package:authorization/features/exercises_search/exercises_search.dart';
import 'package:authorization/features/onboarding/onboarding.dart';
import 'package:authorization/features/tab_bar/tab_bar.dart';
import 'package:authorization/features/firebase_streem/firebase_streem_screen.dart';
import 'package:authorization/features/workout_create/workout_create.dart';
import 'package:authorization/features/workout_details/workout_details.dart';
import 'package:authorization/features/workout_performing/workout_performing.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/workout_settings_bottmo_shett.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/repositories/workouts/models/models.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //Stream
        AutoRoute(page: FirebaseStreamRoute.page, path: '/'),
        AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
        //Authorization
        AutoRoute(page: SignInRoute.page, path: '/singin'),
        AutoRoute(page: SignUpRoute.page, path: '/signup'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset_password'),
        AutoRoute(page: VerifyEmailRoute.page, path: '/verify_email'),
        //Main Content
        AutoRoute(page: TabBarRoute.page, path: '/tab_bar'),
        //Exercises
        AutoRoute(page: ExercisesSearchRoute.page, path: '/exercise_serch'),
        AutoRoute(page: ExerciseDetailsRoute.page, path: '/exercise_details'),
        //Workouts Pages
        AutoRoute(page: WorkoutDetailsRoute.page, path: '/workout_details'),
        AutoRoute(page: WorkoutCreateRoute.page, path: '/workout_create'),
        AutoRoute(
            page: WorkoutPerformingRoute.page, path: '/workout_performing'),

        AutoRoute(
            page: WorkoutSettingsBottomShettRoute.page,
            path: '/workout_settings_bottom_shett'),
      ];
}
