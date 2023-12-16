import 'package:authorization/features/workout_create/bloc/workout_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCreateContent extends StatelessWidget {
  const WorkoutCreateContent({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutCreateBloc = BlocProvider.of<WorkoutCreateBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create workout")),
      body: BlocBuilder<WorkoutCreateBloc, WorkoutCreateState>(
        bloc: workoutCreateBloc,
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
