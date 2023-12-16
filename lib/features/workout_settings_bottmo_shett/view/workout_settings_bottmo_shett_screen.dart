import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/bloc/workout_settings_bottmo_shett_bloc.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class WorkoutSettingsBottomShettScreen extends StatelessWidget {
  WorkoutSettingsBottomShettScreen({
    super.key,
    required this.workoutId,
    required this.isUserOwner,
    required this.isSearchScreen,
  });

  final int workoutId;
  final bool isUserOwner;
  final bool isSearchScreen;

  final workoutSettingsBloc = WorkoutSettingsBloc(
    workoutCreateService: GetIt.I<WorkoutCreateService>(),
    userWorkoutsService: GetIt.I<WorkoutsUserService>(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => workoutSettingsBloc,
      child: BlocListener<WorkoutSettingsBloc, WorkoutSettingsState>(
        listener: (context, state) {
          if (state is NextCreateWorkoutPage) {
            AutoRouter.of(context)
                .push(WorkoutCreateRoute())
                .then((result) => AutoRouter.of(context).pop());
          } else if (state is NextWorkoutsPage) {
            AutoRouter.of(context).pushAndPopUntil(
                TabBarRoute(transitionIndex: 0),
                predicate: (route) => false);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 35),
          height: isSearchScreen
              ? 173
              : isUserOwner
                  ? 295
                  : 234,
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  isSearchScreen
                      ? WorkoutSettingsButton(
                          title: "Copy workout",
                          icon: const Icon(Icons.copy, size: 25),
                          isIcon: true,
                          radiusTop: 15,
                          radiusBottom: 15,
                          onTap: () => workoutSettingsBloc
                              .add(CopyTapped(workoutId: workoutId)),
                        )
                      : Column(
                          children: [
                            WorkoutSettingsButton(
                              title: "Copy workout",
                              icon: const Icon(Icons.copy, size: 25),
                              isIcon: true,
                              radiusTop: 15,
                              radiusBottom: 0,
                              onTap: () => workoutSettingsBloc
                                  .add(CopyTapped(workoutId: workoutId)),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: const Color.fromARGB(255, 209, 209, 209),
                            ),
                            isUserOwner
                                ? Column(
                                    children: [
                                      WorkoutSettingsButton(
                                        title: "Change workout",
                                        icon: Image.asset(
                                            'assets/icons/home/pencil.png',
                                            width: 25,
                                            height: 25),
                                        isIcon: true,
                                        radiusTop: 0,
                                        radiusBottom: 0,
                                        onTap: () => workoutSettingsBloc.add(
                                            ChangeTapped(workoutId: workoutId)),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: const Color.fromARGB(
                                            255, 209, 209, 209),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            WorkoutSettingsButton(
                              title: "Delete workout",
                              icon: const Icon(Icons.delete,
                                  size: 25, color: Colors.red),
                              isIcon: true,
                              color: Colors.red,
                              radiusTop: 0,
                              radiusBottom: 15,
                              onTap: () => showDialog(
                                  barrierColor: Colors.black.withAlpha(50),
                                  context: context,
                                  builder: (context) =>
                                      _createWorkoutSettingsDialog(context)),
                            ),
                          ],
                        ),
                  const SizedBox(height: 18),
                  WorkoutSettingsButton(
                    title: "Cancel",
                    icon: const Icon(Icons.arrow_back_ios, size: 25),
                    isIcon: false,
                    radiusTop: 15,
                    radiusBottom: 15,
                    onTap: () => AutoRouter.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createWorkoutSettingsDialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text("Are you sure you want to delete this workout?"),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
        TextButton(
          child: const Text(
            'Delete workout',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () =>
              workoutSettingsBloc.add(DeleteTapped(workoutId: workoutId)),
        ),
      ],
    );
  }
}
