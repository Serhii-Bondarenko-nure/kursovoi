import 'package:authorization/features/common_widgets/workout_card.dart';
import 'package:authorization/features/main_screens/workout/bloc/workout_bloc.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/view/workout_settings_bottmo_shett_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutContent extends StatelessWidget {
  const WorkoutContent({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutBloc = BlocProvider.of<WorkoutBloc>(context);

    return BlocBuilder<WorkoutBloc, WorkoutState>(
      bloc: workoutBloc..add(LoadWorkoutsList()),
      builder: (context, state) {
        if (state is WorkoutsListLoaded) {
          if (state.workoutsList.isEmpty) {
            return const Center(
                child: Text(
              "Add workouts here...",
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 5,
                left: 16,
                right: 16,
              ),
              itemCount: state.workoutsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 7),
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
                        builder: (context) => WorkoutSettingsBottomShettScreen(
                              workoutId: workout.id,
                              isUserOwner: workout.isUserOwner,
                              isSearchScreen: false,
                            ));
                  },
                );
              },
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
