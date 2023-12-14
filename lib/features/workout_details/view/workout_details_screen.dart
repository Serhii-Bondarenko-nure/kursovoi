import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:authorization/core/services/workouts_firebase_realtime_database_service.dart';
import 'package:authorization/features/workout_details/bloc/workout_details_bloc.dart';
import 'package:authorization/features/workout_details/widgets/workout_details_content.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class WorkoutDetailsScreen extends StatelessWidget {
  WorkoutDetailsScreen({
    super.key,
    required this.workoutId,
    required this.isSearchScreen,
  });

  final int workoutId;
  final bool isSearchScreen;

  final workoutDetailsBloc = WorkoutDetailsBloc(
      userWorkoutsService:
          GetIt.I<UserWorkoutsFirebaseRealtimeDatabaseService>(),
      workoutsRepository: GetIt.I<AbstractWorkoutsRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutDetailsBloc>(
      create: (context) => workoutDetailsBloc,
      child: BlocListener<WorkoutDetailsBloc, WorkoutDetailsState>(
        listener: (context, state) {
          if (state is NextExerciseDetailsPage) {
            AutoRouter.of(context)
                .push(ExerciseDetailsRoute(exerciseId: state.exerciseId));
          } else if (state is NextWorkoutsPage) {
            AutoRouter.of(context).pushAndPopUntil(
                TabBarRoute(transitionIndex: 0),
                predicate: (route) => false);
          } else if (state is NextWorkoutPerformingPage) {
            AutoRouter.of(context)
                .push(WorkoutPerformingRoute(workout: state.workout))
                .then((result) => workoutDetailsBloc.add(
                    LoadWorkoutDetailsEvent(
                        workoutId: workoutId, isSearchScreen: isSearchScreen)));
          } else if (state is WorkoutDetailsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        child: WorkoutDetailsContent(
          workoutId: workoutId,
          isSearchScreen: isSearchScreen,
        ),
      ),
    );
  }
}
