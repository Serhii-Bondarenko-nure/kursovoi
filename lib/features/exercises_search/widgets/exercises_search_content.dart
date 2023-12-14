import 'package:authorization/features/exercises_search/bloc/exercises_search_bloc.dart';
import 'package:authorization/features/exercises_search/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesSearchContent extends StatelessWidget {
  const ExercisesSearchContent(
      {super.key, required this.isWorkoutCreateScreen});

  final bool isWorkoutCreateScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
        centerTitle: true,
      ),
      body: _createMainData(context),
    );
  }

  Widget _createMainData(context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        _createSearch(context),
        const SizedBox(height: 10),
        _createFilters(context),
        const SizedBox(height: 10),
        const Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1.8,
        ),
        Expanded(
          child: _createExercisesListView(context),
        ),
      ],
    );
  }

  Widget _createSearch(context) {
    return const Center(
      child: Text(
        "Search",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _createFilters(context) {
    return const Center(
        child: Column(
      children: [
        Text(
          "Filters",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Equipment",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Target muscles",
              style: TextStyle(color: Colors.black),
            ),
          ],
        )
      ],
    ));
  }

  BlocBuilder<ExercisesSearchBloc, ExercisesSearchState>
      _createExercisesListView(context) {
    final exercisesSearchBloc = BlocProvider.of<ExercisesSearchBloc>(context);
    return BlocBuilder<ExercisesSearchBloc, ExercisesSearchState>(
      bloc: exercisesSearchBloc,
      builder: (BuildContext context, ExercisesSearchState state) {
        if (state is ExercisesListLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 16),
            itemCount: state.exercisesList.length,
            separatorBuilder: (context, index) => const Divider(
              indent: 10,
              endIndent: 10,
            ),
            itemBuilder: (context, i) {
              final exercise = state.exercisesList[i];
              return ExerciseCardTile(
                exercise: exercise,
                isWorkoutCreateScreen: isWorkoutCreateScreen,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
