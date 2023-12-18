import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/features/common_widgets/workout_card.dart';
import 'package:authorization/features/main_screens/workout/bloc/workout_bloc.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/view/workout_settings_bottmo_shett_screen.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutContent extends StatelessWidget {
  const WorkoutContent({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutBloc = BlocProvider.of<WorkoutBloc>(context);

    return BlocBuilder<WorkoutBloc, WorkoutState>(
      bloc: workoutBloc,
      builder: (context, state) {
        if (state is WorkoutsListLoaded) {
          if (state.workoutsList.isEmpty) {
            return const Center(
                child: Text(
              "Add workouts here...",
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 5,
                      left: 16,
                      right: 16,
                    ),
                    itemCount: state.workoutsList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 7),
                    itemBuilder: (context, i) {
                      final workout = state.workoutsList[i];

                      return WorkoutCard(
                        workout: workout,
                        onTap: () {
                          workoutBloc.add(WorkoutDetailsTapped(
                            workoutId: workout.id,
                          ));
                        },
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              barrierColor: Colors.black.withAlpha(50),
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  WorkoutSettingsBottomShettScreen(
                                    workoutId: workout.id,
                                    isUserOwner: workout.isUserOwner,
                                    isSearchScreen: false,
                                  ));
                        },
                      );
                    },
                  ),
                ),
                workoutBloc.isTrainingInProgress
                    ? Container(
                        height: 85,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Training in progress",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                    onPressed: () => AutoRouter.of(context)
                                        .push(WorkoutPerformingRoute()),
                                    icon:
                                        const Icon(Icons.play_arrow, size: 30),
                                    label: const Text(
                                      "Continue",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                TextButton.icon(
                                    onPressed: () => showDialog(
                                        barrierColor:
                                            Colors.black.withAlpha(50),
                                        context: context,
                                        builder: (context) =>
                                            _createWorkoutStopDialog(
                                                context, workoutBloc)),
                                    icon: const Icon(Icons.stop,
                                        size: 30, color: Colors.red),
                                    label: const Text(
                                      "Stop",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createWorkoutStopDialog(
      BuildContext context, WorkoutBloc workoutBloc) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title:
          const Text("Are you sure you want to cancel your current workout?"),
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
            'Cancel workout',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            workoutBloc.add(StopWorkoutTapped());
            AutoRouter.of(context).pop();
          },
        ),
      ],
    );
  }
}
