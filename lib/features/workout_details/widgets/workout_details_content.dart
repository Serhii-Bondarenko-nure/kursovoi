import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/workout_details/bloc/workout_details_bloc.dart';
import 'package:authorization/features/workout_details/widgets/widgets.dart';
import 'package:authorization/features/workout_settings_bottmo_shett/view/workout_settings_bottmo_shett_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutDetailsContent extends StatelessWidget {
  const WorkoutDetailsContent({
    super.key,
    required this.workoutId,
    required this.isSearchScreen,
  });

  final int workoutId;
  final bool isSearchScreen;

  @override
  Widget build(BuildContext context) {
    final workoutDetailsBloc = BlocProvider.of<WorkoutDetailsBloc>(context);

    return Scaffold(
      body: BlocBuilder<WorkoutDetailsBloc, WorkoutDetailsState>(
        bloc: workoutDetailsBloc
          ..add(LoadWorkoutDetailsEvent(
              workoutId: workoutId, isSearchScreen: isSearchScreen)),
        builder: (context, state) {
          if (state is WorkoutDetailsLoaded) {
            return _createBody(context, state);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _createBody(BuildContext context, WorkoutDetailsLoaded state) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: ColorConstants.primaryColor,
                floating: false,
                pinned: true,
                expandedHeight: 260,
                actions: [
                  IconButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        barrierColor: Colors.black.withAlpha(50),
                        backgroundColor: Colors.transparent,
                        builder: (context) => WorkoutSettingsBottomShettScreen(
                          workoutId: workoutId,
                          isUserOwner: state.workout.isUserOwner,
                          isSearchScreen: isSearchScreen,
                        ),
                      ),
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  background: state.workout.isUserOwner
                      ? Container(
                          color: Colors.pink.withBlue(140),
                        )
                      : Image(
                          image: NetworkImage(state.workout.imageUrl),
                          fit: BoxFit.cover,
                        ),
                  title: Text(state.workout.name),
                ),
              ),
              SliverList.list(
                children: [
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: const Color.fromARGB(255, 209, 209, 209),
                  ),
                  state.workout.isUserOwner
                      ? const SizedBox()
                      : _createDescription(context, state.workout),
                  _createExercisesListHeader(context, state.workout),
                  _createExercisesList(context, state),
                ],
              ),
            ],
          ),
        ),
        _createButton(context, state.workout),
      ],
    );
  }

  Widget _createDescription(context, Workout workout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        for (var item in workout.descriptions)
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        const Divider(thickness: 4, color: Color.fromARGB(255, 225, 225, 225)),
      ],
    );
  }

  Widget _createExercisesListHeader(context, Workout workout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 5,
          ),
          child: Text(
            /*"${workout.minutesWorkoutTime} MIN. ·*/ " | ${workout.exercises.length} EXERCISES",
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _createExercisesList(context, WorkoutDetailsLoaded state) {
    final exercises = (state.workout.exercises.values).toList();
    return Column(
      children: [
        for (var i = 0; i < state.workout.exercises.length; i++)
          Column(
            children: [
              ExerciseCardTile(
                exerciseCard: exercises[i],
                exerciseGifUrl: state.exercisesGifUrl[i],
              ),
              i < state.workout.exercises.length - 1
                  ? const Divider(
                      indent: 10,
                      endIndent: 10,
                    )
                  : const SizedBox(),
            ],
          ),
      ],
    );
  }

  Widget _createButton(context, Workout workout) {
    final workoutDetailsBloc = BlocProvider.of<WorkoutDetailsBloc>(context);

    return Column(
      children: [
        const Divider(thickness: 1),
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          child: FitnessButton(
            title: isSearchScreen
                ? "Add a workout"
                : workout.isComplete
                    ? "Run again"
                    : "Begin",
            onTap: () {
              isSearchScreen
                  ? workoutDetailsBloc.add(AddWorkoutTapped(workout: workout))
                  : workout.isComplete
                      ? workoutDetailsBloc
                          .add(RepeatWorkoutTapped(workout: workout))
                      : workoutDetailsBloc
                          .add(StartWorkoutTapped(workout: workout));
            },
          ),
        ),
      ],
    );

    // return Padding(
    //   padding: const EdgeInsets.only(
    //     top: 10,
    //     bottom: 10,
    //   ),
    //   child: ElevatedButton(
    //     onPressed: () {
    //       // isSearchScreen
    //       //     ? workoutDetailsBloc.add(AddWorkoutTapped(workout: workout))
    //       //     : workout.isComplete
    //       //         ? workoutDetailsBloc
    //       //             .add(RepeatWorkoutTapped(workout: workout))
    //       //         : workoutDetailsBloc
    //       //             .add(StartWorkoutTapped(workout: workout));
    //     },
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: ColorConstants.primaryColor,
    //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
    //     ),
    //     child: Text(
    //         isSearchScreen
    //             ? "Add a workout"
    //             : workout.isComplete
    //                 ? "Run again"
    //                 : "Begin",
    //         style: const TextStyle(
    //           color: Colors.white,
    //           fontSize: 24,
    //         )),
    //   ),
    // );
  }
}
