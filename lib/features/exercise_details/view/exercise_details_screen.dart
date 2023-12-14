import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/features/exercise_details/bloc/exercise_details_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gif_view/gif_view.dart';

@RoutePage()
class ExerciseDetailsScreen extends StatelessWidget {
  ExerciseDetailsScreen({
    super.key,
    required this.exerciseId,
  });

  final int exerciseId;
  final GifController gifCntroller = GifController();

  final exerciseDetailsBloc = ExerciseDetailsBloc(
      exersicesRepository: GetIt.I<AbstractExersicesRepository>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          AutoRouter.of(context).pop();
        },
        child: const Text(
          "Back",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _createBody(context) {
    return BlocBuilder<ExerciseDetailsBloc, ExerciseDetailsState>(
      bloc: exerciseDetailsBloc..add(LoadExerciseDetailsEvent(id: exerciseId)),
      builder: (context, state) {
        if (state is ExerciseDetailsLoaded) {
          return ListView(
            children: [
              const SizedBox(height: 14),
              _createTitle(context, state.exercise),
              _createGif(context, state.exercise),
              _createCategories(context, state.exercise),
              const SizedBox(height: 15),
              _createDescription(context, state.exercise),
              const SizedBox(height: 10),
              _createTargetMuscles(context, state.exercise),
              const SizedBox(height: 20),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createTitle(context, Exercise exercise) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Text(
          exercise.name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _createGif(context, Exercise exercise) {
    return GifView.network(
      exercise.gifUrl,
      controller: gifCntroller,
    );
  }

  Widget _createCategories(context, Exercise exercise) {
    const style = TextStyle(
      fontSize: 18,
    );
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        const Text(
          "Categories: ",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${exercise.target}, ",
          style: style,
        ),
        Text(
          "${exercise.bodyPart}, ",
          style: style,
        ),
        Text(
          exercise.equipment,
          style: style,
        ),
      ],
    );
  }

  Widget _createDescription(context, Exercise exercise) {
    const style = TextStyle(
      fontSize: 18,
    );
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: const Text(
                "Description:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (var item in exercise.instructions)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  item,
                  style: style,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _createTargetMuscles(context, Exercise exercise) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: const Text(
            "Target muscles:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _createTargetMuscleButton(true, exercise.target),
              ),
              for (var muscle in exercise.secondaryMuscles)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _createTargetMuscleButton(false, muscle),
                ),
            ],
          ),
        ),
        _createGif(context, exercise),
      ],
    );
  }

  Widget _createTargetMuscleButton(bool isTargetMuscle, String lable) {
    return ElevatedButton.icon(
      icon: Icon(
        Icons.circle,
        color: isTargetMuscle
            ? Colors.red
            : const Color.fromARGB(255, 255, 143, 143),
      ),
      label: Text(
        '${lable[0].toUpperCase()}${lable.substring(1).toLowerCase()}',
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () {},
    );
  }
}
