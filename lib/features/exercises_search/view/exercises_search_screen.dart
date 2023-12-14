import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/features/exercises_search/bloc/exercises_search_bloc.dart';
import 'package:authorization/features/exercises_search/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ExercisesSearchScreen extends StatelessWidget {
  ExercisesSearchScreen({super.key, required this.isWorkoutCreateScreen});

  final bool isWorkoutCreateScreen;

  final exercisesSearchBloc = ExercisesSearchBloc(
      exersicesRepository: GetIt.I<AbstractExersicesRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExercisesSearchBloc>(
      create: (BuildContext context) =>
          exercisesSearchBloc..add(LoadExercisesList()),
      child: BlocListener<ExercisesSearchBloc, ExercisesSearchState>(
        listener: (context, state) {
          if (state is NextExerciseDetailsPage) {
            AutoRouter.of(context)
                .push(ExerciseDetailsRoute(exerciseId: state.exerciseId))
                .then((result) => exercisesSearchBloc.add(LoadExercisesList()));
          } else if (state is NextWorkoutCreatePage) {
            // TODO: Сделать переход, какой - пока не знаю
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.exeption.toString())),
            );
          }
        },
        child: ExercisesSearchContent(
            isWorkoutCreateScreen: isWorkoutCreateScreen),
      ),
    );
  }
}
