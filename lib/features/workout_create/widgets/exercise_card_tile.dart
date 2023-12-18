import 'package:authorization/core/repositories/workouts/models/exercise_card.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/features/workout_create/bloc/workout_create_bloc/workout_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gif_view/gif_view.dart';

class ExerciseCardTile extends StatelessWidget {
  ExerciseCardTile({
    super.key,
    required this.exerciseNum,
    required this.exerciseCard,
    required this.exerciseGifUrl,
  });

  final int exerciseNum;
  final ExerciseCard exerciseCard;
  final String exerciseGifUrl;
  final GifController gifCntroller = GifController(autoPlay: false);

  final exerciseSetsController = TextEditingController();
  final exerciseRepetitionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (exerciseCard.sets > 0) {
      exerciseSetsController.text = exerciseCard.sets.toString();
    }
    if (exerciseCard.repetitions > 0) {
      exerciseRepetitionsController.text = exerciseCard.repetitions.toString();
    }
    exerciseSetsController.selection =
        TextSelection.collapsed(offset: exerciseSetsController.text.length);
    exerciseRepetitionsController.selection = TextSelection.collapsed(
        offset: exerciseRepetitionsController.text.length);

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GifView.network(
            exerciseGifUrl,
            controller: gifCntroller,
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Text(
                    "${exerciseCard.name} (${exerciseCard.target})",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Sets: ", style: TextStyle(fontSize: 16)),
                      _createTextField(
                        context,
                        "Sets",
                        exerciseSetsController,
                        (text) async {
                          if (exerciseSetsController.text.isNotEmpty) {
                            await GetIt.I<WorkoutCreateService>()
                                .updateExerciseSetsById(exerciseNum,
                                    int.parse(exerciseSetsController.text));
                          }
                        },
                      ),
                      const SizedBox(width: 15),
                      const Text("Rep: ", style: TextStyle(fontSize: 16)),
                      _createTextField(
                        context,
                        "Rep.",
                        exerciseRepetitionsController,
                        (text) async {
                          if (exerciseRepetitionsController.text.isNotEmpty) {
                            await GetIt.I<WorkoutCreateService>()
                                .updateExerciseRepetitionsById(
                                    exerciseNum,
                                    int.parse(
                                        exerciseRepetitionsController.text));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              final workoutCreateBloc =
                  BlocProvider.of<WorkoutCreateBloc>(context);
              workoutCreateBloc
                  .add(DeleteExerciseTapped(exercisesNumber: exerciseNum));
            },
            icon: const Icon(
              Icons.delete,
              size: 25,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTextField(BuildContext context, String title,
      TextEditingController controller, void Function(String)? onChanged) {
    return Container(
      width: 50,
      height: 20,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
