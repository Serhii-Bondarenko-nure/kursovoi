import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/features/exercises_search/bloc/exercises_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';

class ExerciseCardTile extends StatelessWidget {
  ExerciseCardTile({
    super.key,
    required this.exercise,
    required this.isWorkoutCreateScreen,
  });

  final Exercise exercise;
  final bool isWorkoutCreateScreen;
  final GifController gifCntroller = GifController(autoPlay: false);

  @override
  Widget build(BuildContext context) {
    final exercisesSearchBloc = BlocProvider.of<ExercisesSearchBloc>(context);

    return ListTile(
      leading: GifView.network(
        exercise.gifUrl,
        controller: gifCntroller,
      ),
      title: Text(
        exercise.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        exercise.target,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      trailing: isWorkoutCreateScreen
          ? IconButton(
              iconSize: 40,
              icon: const Icon(Icons.add),
              onPressed: () {
                exercisesSearchBloc
                    .add(WorkoutCreateTapped(exercise: exercise));
              },
            )
          : const Icon(Icons.arrow_forward_ios),
      onTap: () {
        exercisesSearchBloc.add(ExerciseDetailsTapped(exerciseId: exercise.id));
      },
    );
  }
}
