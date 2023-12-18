import 'package:authorization/features/common_widgets/fitness_button.dart';
import 'package:authorization/features/workout_create/bloc/workout_create_bloc/workout_create_bloc.dart';
import 'package:authorization/features/workout_create/widgets/exercise_card_tile.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCreateContent extends StatelessWidget {
  const WorkoutCreateContent({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutCreateBloc = BlocProvider.of<WorkoutCreateBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 28),
          child: Text("Create workout"),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (workoutCreateBloc.exercisesLengs != 0) {
              showDialog(
                  barrierColor: Colors.black.withAlpha(50),
                  context: context,
                  builder: (context) => _createCanceleDialog(context));
            } else {
              AutoRouter.of(context).pushAndPopUntil(
                TabBarRoute(transitionIndex: 0),
                predicate: (route) => false,
              );
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 2),
            child: TextButton(
              onPressed: () {
                if (workoutCreateBloc.workoutNameController.text.isEmpty) {
                  showDialog(
                      barrierColor: Colors.black.withAlpha(50),
                      context: context,
                      builder: (context) => _createSaveDialog(
                          context, "The workout must have a name."));
                } else if (workoutCreateBloc.exercisesLengs == 0) {
                  showDialog(
                      barrierColor: Colors.black.withAlpha(50),
                      context: context,
                      builder: (context) => _createSaveDialog(context,
                          "There should be at least one exercise in your workout."));
                } else {
                  workoutCreateBloc.add(SaveWorkoutTapped());
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createWorkoutNameInput(context),
              _createExercisesList(context),
              _createAddExerciseButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createWorkoutNameInput(BuildContext context) {
    final workoutCreateBloc = BlocProvider.of<WorkoutCreateBloc>(context);

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: TextField(
        controller: workoutCreateBloc.workoutNameController,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          hintText: "Workout name",
          hintStyle: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onChanged: (text) {
          workoutCreateBloc.workoutCreateService.updateWorkoutName(text);
        },
      ),
    );
  }

  Widget _createExercisesList(BuildContext context) {
    final workoutCreateBloc = BlocProvider.of<WorkoutCreateBloc>(context);

    return BlocBuilder<WorkoutCreateBloc, WorkoutCreateState>(
      bloc: workoutCreateBloc..add(LoadWorkoutCreateData()),
      builder: (context, state) {
        if (state is WorkoutCreateDataLoaded) {
          if (state.workout.exercises.isEmpty) {
            return const SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  "Start by adding exercises to your program.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            final exercises = state.workout.exercises.values.toList();
            return SizedBox(
              height: MediaQuery.of(context).size.height - 250,
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, i) {
                  return ExerciseCardTile(
                    exerciseCard: exercises[i],
                    exerciseGifUrl: state.exercisesGifUrl[i],
                    exerciseNum: i,
                  );
                },
              ),

              // ReorderableListView.builder(
              //   itemCount: exercises.length,
              //   itemBuilder: (context, i) {
              //     return ExerciseCardTile(
              //       key: ValueKey(i),
              //       exerciseCard: exercises[i],
              //       exerciseGifUrl: state.exercisesGifUrl[i],
              //       exercisesNum: i,
              //     );
              //   },
              //   onReorder: (int oldIndex, int newIndex) {
              //     if (oldIndex < newIndex) {
              //       newIndex -= 1;
              //     }
              //     final ExerciseCard item = exercises.removeAt(oldIndex);
              //     exercises.insert(newIndex, item);
              //   },
              // ),

              //  ReorderableListView(
              //   onReorder: (int oldIndex, int newIndex) {},
              //   children: [
              //     for (final tile in state.workout.exercises.values)
              //       ExerciseCardTile(
              //         key: ValueKey(i),
              //         exerciseCard: tile,
              //         exerciseGifUrl: state.exercisesGifUrl[i],
              //         exercisesNum: i++,
              //       ),
              //   ],
              // ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createAddExerciseButton(BuildContext context) {
    final workoutCreateBloc = BlocProvider.of<WorkoutCreateBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 250,
            child: FitnessButton(
                title: "+ Add exercise",
                onTap: () => workoutCreateBloc.add(AddExerciseTapped())),
          ),
        ],
      ),
    );
  }

  Widget _createSaveDialog(BuildContext context, String title) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text(title),
      actions: [
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
      ],
    );
  }

  Widget _createCanceleDialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: const Text("Are you sure you want to give up this workout?"),
      actions: [
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
        TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () => AutoRouter.of(context).pushAndPopUntil(
                  TabBarRoute(transitionIndex: 0),
                  predicate: (route) => false,
                )),
      ],
    );
  }
}
