import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/features/workout_performing/bloc/workout_performing_bloc/workout_performing_bloc.dart';
import 'package:authorization/features/workout_performing/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class WorkoutPerformingScreen extends StatelessWidget {
  WorkoutPerformingScreen({
    super.key,
  });

  WorkoutPerformingBloc workoutPerformingBloc = WorkoutPerformingBloc(
    workoutPerformingService: GetIt.I<WorkoutPerformingService>(),
    exersicesRepository: GetIt.I<AbstractExersicesRepository>(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutPerformingBloc>(
      create: (context) => workoutPerformingBloc,
      child: WorkoutPerformingContente(),
    );
  }
}
