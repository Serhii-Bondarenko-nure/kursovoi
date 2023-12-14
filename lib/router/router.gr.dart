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
    ResetPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResetPasswordScreen(),
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
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WorkoutCreateScreen(),
      );
    },
    WorkoutDeleteRoute.name: (routeData) {
      final args = routeData.argsAs<WorkoutDeleteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutDeleteScreen(
          key: args.key,
          workoutId: args.workoutId,
        ),
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
      final args = routeData.argsAs<WorkoutPerformingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WorkoutPerformingScreen(
          key: args.key,
          workout: args.workout,
        ),
      );
    },
  };
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
class WorkoutCreateRoute extends PageRouteInfo<void> {
  const WorkoutCreateRoute({List<PageRouteInfo>? children})
      : super(
          WorkoutCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WorkoutDeleteScreen]
class WorkoutDeleteRoute extends PageRouteInfo<WorkoutDeleteRouteArgs> {
  WorkoutDeleteRoute({
    Key? key,
    required int workoutId,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutDeleteRoute.name,
          args: WorkoutDeleteRouteArgs(
            key: key,
            workoutId: workoutId,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutDeleteRoute';

  static const PageInfo<WorkoutDeleteRouteArgs> page =
      PageInfo<WorkoutDeleteRouteArgs>(name);
}

class WorkoutDeleteRouteArgs {
  const WorkoutDeleteRouteArgs({
    this.key,
    required this.workoutId,
  });

  final Key? key;

  final int workoutId;

  @override
  String toString() {
    return 'WorkoutDeleteRouteArgs{key: $key, workoutId: $workoutId}';
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
    required Workout workout,
    List<PageRouteInfo>? children,
  }) : super(
          WorkoutPerformingRoute.name,
          args: WorkoutPerformingRouteArgs(
            key: key,
            workout: workout,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutPerformingRoute';

  static const PageInfo<WorkoutPerformingRouteArgs> page =
      PageInfo<WorkoutPerformingRouteArgs>(name);
}

class WorkoutPerformingRouteArgs {
  const WorkoutPerformingRouteArgs({
    this.key,
    required this.workout,
  });

  final Key? key;

  final Workout workout;

  @override
  String toString() {
    return 'WorkoutPerformingRouteArgs{key: $key, workout: $workout}';
  }
}