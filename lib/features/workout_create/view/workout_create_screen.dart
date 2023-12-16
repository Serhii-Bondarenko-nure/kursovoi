import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/features/workout_create/bloc/workout_create_bloc.dart';
import 'package:authorization/features/workout_create/widgets/workout_create_content.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class WorkoutCreateScreen extends StatelessWidget {
  WorkoutCreateScreen({
    super.key,
  });

  final workoutCreateBloc = WorkoutCreateBloc(
      workoutCreateService: GetIt.I<WorkoutCreateService>(),
      exersicesRepository: GetIt.I<AbstractExersicesRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutCreateBloc>(
        create: (context) => workoutCreateBloc..add(LoadWorkoutCreateData()),
        child: BlocListener<WorkoutCreateBloc, WorkoutCreateState>(
          listener: (context, state) {
            if (state is NextWorkoutsPage) {
              AutoRouter.of(context).pushAndPopUntil(
                  TabBarRoute(transitionIndex: 0),
                  predicate: (route) => false);
            } else if (state is NextExercisesSearchPage) {
              AutoRouter.of(context)
                  .push(ExercisesSearchRoute(
                      isWorkoutCreateScreen: state.isWorkoutCreateScreen))
                  .then((result) =>
                      workoutCreateBloc.add(LoadWorkoutCreateData()));
            } else if (state is ExerciseDeleted) {
              workoutCreateBloc.add(LoadWorkoutCreateData());
            } else if (state is WorkoutCreateDataErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exeption.toString())));
            }
          },
          child: WorkoutCreateContent(),
        ));
  }
}
