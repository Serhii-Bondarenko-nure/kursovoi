import 'package:authorization/core/services/workouts_service.dart';
import 'package:authorization/features/main_screens/search/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:authorization/features/main_screens/search/widgets/widgets.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchBloc =
      SearchScreenBloc(workoutsService: GetIt.I<WorkoutsService>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchScreenBloc>(
      create: (context) => searchBloc..add(LoadTypesList()),
      child: BlocListener<SearchScreenBloc, SearchScreenState>(
        listener: (context, state) {
          if (state is NextWorkoutDetailsPage) {
            AutoRouter.of(context)
                .push(WorkoutDetailsRoute(
                  workoutId: state.workoutId,
                  isSearchScreen: true,
                ))
                .then((result) => searchBloc.add(LoadTypesList()));
          } else if (state is SearchErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        child: const SearchContent(),
      ),
    );
  }
}
