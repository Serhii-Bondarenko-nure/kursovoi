// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChangePasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangePasswordScreen(),
      );
    },
    EditAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditAccountScreen(),
      );
    },
    ExerciseDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ExerciseDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExerciseDetailsScreen(
          key: args.key,
          exerciseId: args.exerciseId,
        ),
      );
    },
    ExercisesSearchRoute.name: (routeData) {
      final args = routeData.argsAs<ExercisesSearchRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExercisesSearchScreen(
          key: args.key,
          isWorkoutCreateScreen: args.isWorkoutCreateScreen,
        ),
      );
    },
    FirebaseStreamRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FirebaseStreamScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    ReminderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReminderPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResetPasswordScreen(),
      );
    },
    SetInitialUserParamRoute.name: (routeData) {
      final args = routeData.argsAs<SetInitialUserParamRouteArgs>(
          orElse: () => const SetInitialUserParamRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SetInitialUserParamScreen(key: args.key),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpScreen(),
      );
    },
    TabBarRoute.name: (routeData) {
      final args = routeData.argsAs<TabBarRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TabBarScreen(
          key: args.key,
          transitionIndex: args.transitionIndex,
        ),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VerifyEmailScreen(),
      );
    },
    WorkoutCreateRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutCreateRouteArgs>(
          orElse: () => const WorkoutCreateRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutCreateScreen(key: args.key),
      );
    },
    WorkoutDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutDetailsScreen(
          key: args.key,
          workoutId: args.workoutId,
          isSearchScreen: args.isSearchScreen,
        ),
      );
    },
    WorkoutPerformingRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutPerformingRouteArgs>(
          orElse: () => const WorkoutPerformingRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutPerformingScreen(key: args.key),
      );
    },
    WorkoutSettingsBottomShettRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutSettingsBottomShettRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutSettingsBottomShettScreen(
          key: args.key,
          workoutId: args.workoutId,
          isUserOwner: args.isUserOwner,
          isSearchScreen: args.isSearchScreen,
        ),
      );
    },
  };
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditAccountScreen]
class EditAccountRoute extends PageRouteInfo<void> {
  const EditAccountRoute({List<PageRouteInfo>? children})
      : super(
          EditAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExerciseDetailsScreen]
class ExerciseDetailsRoute extends PageRouteInfo<ExerciseDetailsRouteArgs> {
  ExerciseDetailsRoute({
    Key? key,
    required int exerciseId,
    List<PageRouteInfo>? children,
  }) : super(
          ExerciseDetailsRoute.name,
          args: ExerciseDetailsRouteArgs(
            key: key,
            exerciseId: exerciseId,
          ),
          initialChildren: children,
        );

  static const String name = 'ExerciseDetailsRoute';

  static const PageInfo<ExerciseDetailsRouteArgs> page =
      PageInfo<ExerciseDetailsRouteArgs>(name);
}

class ExerciseDetailsRouteArgs {
  const ExerciseDetailsRouteArgs({
    this.key,
    required this.exerciseId,
  });

  final Key? key;

  final int exerciseId;

  @override
  String toString() {
    return 'ExerciseDetailsRouteArgs{key: $key, exerciseId: $exerciseId}';
  }
}

/// generated route for
/// [ExercisesSearchScreen]
class ExercisesSearchRoute extends PageRouteInfo<ExercisesSearchRouteArgs> {
  ExercisesSearchRoute({
    Key? key,
    required bool isWorkoutCreateScreen,
    List<PageRouteInfo>? children,
  }) : super(
          ExercisesSearchRoute.name,
          args: ExercisesSearchRouteArgs(
            key: key,
            isWorkoutCreateScreen: isWorkoutCreateScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'ExercisesSearchRoute';

  static const PageInfo<ExercisesSearchRouteArgs> page =
      PageInfo<ExercisesSearchRouteArgs>(name);
}

class ExercisesSearchRouteArgs {
  const ExercisesSearchRouteArgs({
    this.key,
    required this.isWorkoutCreateScreen,
  });

  final Key? key;

  final bool isWorkoutCreateScreen;

  @override
  String toString() {
    return 'ExercisesSearchRouteArgs{key: $key, isWorkoutCreateScreen: $isWorkoutCreateScreen}';
  }
}

/// generated route for
/// [FirebaseStreamScreen]
class FirebaseStreamRoute extends PageRouteInfo<void> {
  const FirebaseStreamRoute({List<PageRouteInfo>? children})
      : super(
          FirebaseStreamRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirebaseStreamRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReminderPage]
class ReminderRoute extends PageRouteInfo<void> {
  const ReminderRoute({List<PageRouteInfo>? children})
      : super(
          ReminderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReminderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SetInitialUserParamScreen]
class SetInitialUserParamRoute
    extends PageRouteInfo<SetInitialUserParamRouteArgs> {
  SetInitialUserParamRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SetInitialUserParamRoute.name,
          args: SetInitialUserParamRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SetInitialUserParamRoute';

  static const PageInfo<SetInitialUserParamRouteArgs> page =
      PageInfo<SetInitialUserParamRouteArgs>(name);
}

class SetInitialUserParamRouteArgs {
  const SetInitialUserParamRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SetInitialUserParamRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabBarScreen]
class TabBarRoute extends PageRouteInfo<TabBarRouteArgs> {
  TabBarRoute({
    Key? key,
    required int transitionIndex,
    List<PageRouteInfo>? children,
  }) : super(
          TabBarRoute.name,
          args: TabBarRouteArgs(
            key: key,
            transitionIndex: transitionIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'TabBarRoute';

  static const PageInfo<TabBarRouteArgs> page = PageInfo<TabBarRouteArgs>(name);
}

class TabBarRouteArgs {
  const TabBarRouteArgs({
    this.key,
    required this.transitionIndex,
  });

  final Key? key;

  final int transitionIndex;

  @override
  String toString() {
    return 'TabBarRouteArgs{key: $key, transitionIndex: $transitionIndex}';
  }
}

/// generated route for
/// [VerifyEmailScreen]
class VerifyEmailRoute extends PageRouteInfo<void> {
  const VerifyEmailRoute({List<PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkoutCreateScreen]
class WorkoutCreateRoute extends PageRouteInfo<WorkoutCreateRouteArgs> {
  WorkoutCreateRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutCreateRoute.name,
          args: WorkoutCreateRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WorkoutCreateRoute';

  static const PageInfo<WorkoutCreateRouteArgs> page =
      PageInfo<WorkoutCreateRouteArgs>(name);
}

class WorkoutCreateRouteArgs {
  const WorkoutCreateRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'WorkoutCreateRouteArgs{key: $key}';
  }
}

/// generated route for
/// [WorkoutDetailsScreen]
class WorkoutDetailsRoute extends PageRouteInfo<WorkoutDetailsRouteArgs> {
  WorkoutDetailsRoute({
    Key? key,
    required int workoutId,
    required bool isSearchScreen,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutDetailsRoute.name,
          args: WorkoutDetailsRouteArgs(
            key: key,
            workoutId: workoutId,
            isSearchScreen: isSearchScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutDetailsRoute';

  static const PageInfo<WorkoutDetailsRouteArgs> page =
      PageInfo<WorkoutDetailsRouteArgs>(name);
}

class WorkoutDetailsRouteArgs {
  const WorkoutDetailsRouteArgs({
    this.key,
    required this.workoutId,
    required this.isSearchScreen,
  });

  final Key? key;

  final int workoutId;

  final bool isSearchScreen;

  @override
  String toString() {
    return 'WorkoutDetailsRouteArgs{key: $key, workoutId: $workoutId, isSearchScreen: $isSearchScreen}';
  }
}

/// generated route for
/// [WorkoutPerformingScreen]
class WorkoutPerformingRoute extends PageRouteInfo<WorkoutPerformingRouteArgs> {
  WorkoutPerformingRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutPerformingRoute.name,
          args: WorkoutPerformingRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'WorkoutPerformingRoute';

  static const PageInfo<WorkoutPerformingRouteArgs> page =
      PageInfo<WorkoutPerformingRouteArgs>(name);
}

class WorkoutPerformingRouteArgs {
  const WorkoutPerformingRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'WorkoutPerformingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [WorkoutSettingsBottomShettScreen]
class WorkoutSettingsBottomShettRoute
    extends PageRouteInfo<WorkoutSettingsBottomShettRouteArgs> {
  WorkoutSettingsBottomShettRoute({
    Key? key,
    required int workoutId,
    required bool isUserOwner,
    required bool isSearchScreen,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutSettingsBottomShettRoute.name,
          args: WorkoutSettingsBottomShettRouteArgs(
            key: key,
            workoutId: workoutId,
            isUserOwner: isUserOwner,
            isSearchScreen: isSearchScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutSettingsBottomShettRoute';

  static const PageInfo<WorkoutSettingsBottomShettRouteArgs> page =
      PageInfo<WorkoutSettingsBottomShettRouteArgs>(name);
}

class WorkoutSettingsBottomShettRouteArgs {
  const WorkoutSettingsBottomShettRouteArgs({
    this.key,
    required this.workoutId,
    required this.isUserOwner,
    required this.isSearchScreen,
  });

  final Key? key;

  final int workoutId;

  final bool isUserOwner;

  final bool isSearchScreen;

  @override
  String toString() {
    return 'WorkoutSettingsBottomShettRouteArgs{key: $key, workoutId: $workoutId, isUserOwner: $isUserOwner, isSearchScreen: $isSearchScreen}';
  }
}
