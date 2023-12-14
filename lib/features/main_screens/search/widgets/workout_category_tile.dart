import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/repositories/workouts/abstract_workouts_repository.dart';
import 'package:authorization/features/common_widgets/workout_card.dart';
import 'package:authorization/features/main_screens/search/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:authorization/features/main_screens/search/bloc/workout_card_bloc/workout_card_bloc.dart';
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
    final workoutCardBloc = WorkoutCardBloc(
        workoutsRepository: GetIt.I<AbstractWorkoutsRepository>());

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
                child: Text(
                  workoutCardBloc.isCollapsed ? "Expand" : "Collapse",
                  style: const TextStyle(color: ColorConstants.primaryColor),
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
