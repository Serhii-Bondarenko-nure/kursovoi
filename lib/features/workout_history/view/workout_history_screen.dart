import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/features/workout_history/bloc/workout_history_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class WorkoutHistoryScreen extends StatelessWidget {
  WorkoutHistoryScreen({super.key});

  final workoutHistoryBloc = WorkoutsHistoryBloc(
      workoutPerformingService: GetIt.I<WorkoutPerformingService>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutsHistoryBloc>(
      create: (context) => workoutHistoryBloc..add(LoadWorkoutsHistory()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Workouts history"),
        ),
        body: BlocBuilder<WorkoutsHistoryBloc, WorkoutsHistoryState>(
          builder: (context, state) {
            if (state is WorkoutsHistoryLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(14),
                itemCount: state.workouts.length,
                separatorBuilder: (context, i) {
                  return const Divider();
                },
                itemBuilder: (context, i) {
                  return _createWorkoutCardTile(context, state.workouts[i]);
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _createWorkoutCardTile(BuildContext context, Workout workout) {
    final String date =
        "${workout.lastComplete!.day}.${workout.lastComplete!.month}.${workout.lastComplete!.year}  ${workout.lastComplete!.hour}:${workout.lastComplete!.minute == 0 ? "00" : workout.lastComplete!.minute}";

    // String workoutTime = workout.minutesWorkoutTime < 60
    //     ? "${workout.minutesWorkoutTime} MIN"
    //     : "${workout.minutesWorkoutTime ~/ 60}:${workout.minutesWorkoutTime - workout.minutesWorkoutTime ~/ 60 * 60}";

    return ListTile(
      leading: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(workout.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            workout.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Text(
        "${workout.minutesWorkoutTime} MIN",
        style: const TextStyle(fontSize: 14),
      ),
      onTap: () {},
    );
  }
}
