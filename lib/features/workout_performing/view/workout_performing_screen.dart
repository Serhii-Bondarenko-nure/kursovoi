import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WorkoutPerformingScreen extends StatelessWidget {
  const WorkoutPerformingScreen({
    super.key,
    required this.workout,
  });

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Выполнение тренировки: ${workout.name}")),
    );
  }
}
