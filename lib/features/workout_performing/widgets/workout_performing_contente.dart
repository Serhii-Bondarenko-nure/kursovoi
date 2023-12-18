import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/workout_performing/bloc/workout_performing_bloc/workout_performing_bloc.dart';
import 'package:authorization/features/workout_performing/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutPerformingContente extends StatelessWidget {
  const WorkoutPerformingContente({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutPerformingBloc =
        BlocProvider.of<WorkoutPerformingBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout performing"),
      ),
      body: BlocConsumer<WorkoutPerformingBloc, WorkoutPerformingState>(
        bloc: workoutPerformingBloc..add(LoadWorkoutPerformingData()),
        listener: (context, state) {
          if (state is NextStaticticsPage) {
            AutoRouter.of(context).pushAndPopUntil(
                TabBarRoute(transitionIndex: 3),
                predicate: (route) => false);
          } else if (state is NextExerciseDetailsPage) {
            AutoRouter.of(context)
                .push(ExerciseDetailsRoute(exerciseId: state.exerciseId))
                .then((result) =>
                    workoutPerformingBloc.add(LoadWorkoutPerformingData()));
          } else if (state is WorkoutPerformingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        builder: (context, state) {
          if (state is WorkoutPerformingDataLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _createTitle(context, state.workout.name),
                  _createExercisesList(context, state),
                  _createCompleteButton(context, state),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _createTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _createExercisesList(
      BuildContext context, WorkoutPerformingDataLoaded state) {
    final exercisesList = state.workout.exercises.values.toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height - 240,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: exercisesList.length,
        separatorBuilder: (context, i) {
          return const SizedBox(height: 5);
        },
        itemBuilder: (context, i) {
          return ExerciseCardTile(
            exerciseNumber: i,
            exerciseCard: exercisesList[i],
            exerciseGifUrl: state.exercisesGifUrl[i],
            workoutPerformingBloc:
                BlocProvider.of<WorkoutPerformingBloc>(context),
          );
        },
      ),
    );
  }

  Widget _createCompleteButton(
      BuildContext context, WorkoutPerformingDataLoaded state) {
    final workoutPerformingBloc =
        BlocProvider.of<WorkoutPerformingBloc>(context);

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
            title: "Complete workout",
            onTap: () async {
              final isComplete = await workoutPerformingBloc
                  .workoutPerformingService
                  .getWorkoutIsCompleteTrue();

              isComplete
                  ? workoutPerformingBloc
                      .add(WorkoutCompleteTapped(workoutId: state.workout.id))
                  : showDialog(
                      barrierColor: Colors.black.withAlpha(50),
                      context: context,
                      builder: (context) => _createWorkoutChoiseDialog(
                          context, workoutPerformingBloc));
            },
          ),
        ),
      ],
    );
  }

  Widget _createWorkoutChoiseDialog(
      BuildContext context, WorkoutPerformingBloc workoutDetailsBloc) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text("You must complete all the exercises"),
      actions: [
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            AutoRouter.of(context).pop();
          },
        ),
      ],
    );
  }
}
