import 'package:authorization/core/repositories/workouts/models/exercise_card.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/features/workout_performing/bloc/exercise_card_bloc/exercise_card_bloc.dart';
import 'package:authorization/features/workout_performing/bloc/workout_performing_bloc/workout_performing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gif_view/gif_view.dart';

class ExerciseCardTile extends StatelessWidget {
  ExerciseCardTile({
    super.key,
    required this.exerciseNumber,
    required this.exerciseCard,
    required this.exerciseGifUrl,
    required this.workoutPerformingBloc,
  });

  final int exerciseNumber;
  final ExerciseCard exerciseCard;
  final String exerciseGifUrl;
  final WorkoutPerformingBloc workoutPerformingBloc;

  final exerciseCardBloc = ExerciseCardBloc(
      workoutPerformingService: GetIt.I<WorkoutPerformingService>());
  final GifController gifCntroller = GifController(autoPlay: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseCardBloc, ExerciseCardState>(
      bloc: exerciseCardBloc
        ..add(LoadExerciseCard(exerciseNumber: exerciseNumber)),
      listener: (context, state) => {
        if (state is NextReloadExerciseCard)
          {
            exerciseCardBloc
                .add(LoadExerciseCard(exerciseNumber: exerciseNumber))
          }
      },
      builder: (context, state) {
        if (state is ExerciseCardLoaded) {
          final flags = state.flags.values.toList();
          return GestureDetector(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => workoutPerformingBloc
                      .add(ExerciseDetailsTapped(exerciseId: exerciseCard.id)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GifView.network(
                        exerciseGifUrl,
                        controller: gifCntroller,
                        width: 60,
                        height: 60,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 120,
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: Text(
                          "${exerciseCard.name} (${exerciseCard.target})",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < exerciseCard.sets; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: _createSetTile(context, i, flags[i]),
                  )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createSetTile(BuildContext context, int setNumber, bool flag) {
    return Container(
      color: flag
          ? const Color.fromARGB(255, 189, 255, 191)
          : setNumber % 2 != 0
              ? const Color.fromARGB(255, 232, 231, 231)
              : Colors.white,
      child: ListTile(
        title: Text(
          "Set: ${setNumber + 1} x ${exerciseCard.repetitions}",
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        trailing: IconButton(
            onPressed: () => exerciseCardBloc.add(ExerciseSetTapped(
                exerciseNumber: exerciseNumber,
                setNumber: setNumber,
                flag: !flag)),
            icon: const Icon(
              Icons.check_box,
              size: 30,
            )),
      ),
    );
  }
}
