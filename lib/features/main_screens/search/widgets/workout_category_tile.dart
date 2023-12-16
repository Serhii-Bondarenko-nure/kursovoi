import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/services/workouts_service.dart';
import 'package:authorization/features/common_widgets/workout_card.dart';
import 'package:authorization/features/main_screens/search/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:authorization/features/main_screens/search/bloc/workout_card_bloc/workout_card_bloc.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/workout_settings_bottmo_shett.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class WorkoutCategoryTile extends StatelessWidget {
  const WorkoutCategoryTile({super.key, required this.workoutType});

  final String workoutType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          workoutType,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        _createCategoryData(context),
      ],
    );
  }

  Widget _createCategoryData(context) {
    final workoutCardBloc =
        WorkoutCardBloc(workoutsService: GetIt.I<WorkoutsService>());

    return BlocConsumer<WorkoutCardBloc, WorkoutCardState>(
      bloc: workoutCardBloc
        ..add(LoadWorkoutsListByType(workoutType: workoutType)),
      listener: (context, state) {
        if (state is WorkoutCardErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.exeption.toString())),
          );
        }
      },
      builder: (context, state) {
        if (state is WorkoutsListByTypeLoaded) {
          return Column(
            children: [
              for (var i = 0;
                  i <
                      (workoutCardBloc.isCollapsed
                          ? 3
                          : state.workoutsListByType.length);
                  i++)
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: WorkoutCard(
                    workout: state.workoutsListByType[i],
                    onTap: () {
                      BlocProvider.of<SearchScreenBloc>(context)
                          .add(WorkoutDetailsTapped(
                        workoutId: state.workoutsListByType[i].id,
                      ));
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.black.withAlpha(50),
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              WorkoutSettingsBottomShettScreen(
                                workoutId: state.workoutsListByType[i].id,
                                isUserOwner:
                                    state.workoutsListByType[i].isUserOwner,
                                isSearchScreen: true,
                              ));
                    },
                  ),
                ),
              // TextButton(
              //   onPressed: () {
              //     workoutCardBloc.add(CollapsedWorkoutsList());
              //     workoutCardBloc
              //         .add(LoadWorkoutsListByType(workoutType: workoutType));
              //   },
              //   child: Text(
              //     workoutCardBloc.isCollapsed ? "Expand" : "Collapse",
              //   ),
              // ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () {
                  workoutCardBloc.add(CollapsedWorkoutsList());
                  workoutCardBloc
                      .add(LoadWorkoutsListByType(workoutType: workoutType));
                },
                child: state.workoutsListByType.length > 3
                    ? Text(
                        workoutCardBloc.isCollapsed ? "Expand" : "Collapse",
                        style:
                            const TextStyle(color: ColorConstants.primaryColor),
                      )
                    : const SizedBox(height: 10),
              ),
              const SizedBox(height: 7),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
