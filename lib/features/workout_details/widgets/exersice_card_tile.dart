import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:authorization/features/workout_details/bloc/workout_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';

class ExerciseCardTile extends StatelessWidget {
  ExerciseCardTile({
    super.key,
    required this.exerciseCard,
  });

  final ExerciseCard exerciseCard;
  final GifController gifCntroller = GifController(autoPlay: false);

  @override
  Widget build(BuildContext context) {
    final workoutDetailsBloc = BlocProvider.of<WorkoutDetailsBloc>(context);

    return ListTile(
      leading: GifView.network(
        exerciseCard.gifUrl,
        controller: gifCntroller,
      ),
      title: Text(
        exerciseCard.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        "${exerciseCard.sets}x${exerciseCard.repetitions}",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      // SizedBox(
      //   width: 100,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Text(
      //         "${exerciseCard.sets}x${exerciseCard.repetitions}",
      //         style: const TextStyle(fontSize: 18),
      //       ),
      //       const SizedBox(width: 15),
      //       const Icon(Icons.arrow_forward_ios),
      //     ],
      //   ),
      // ),
      onTap: () {
        workoutDetailsBloc
            .add(ExerciseDetailsTapped(exerciseId: exerciseCard.id));
      },
    );
  }
}
