import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WorkoutDeleteScreen extends StatelessWidget {
  const WorkoutDeleteScreen({
    super.key,
    required this.workoutId,
  });

  final int workoutId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete $workoutId"),
      ),
    );
  }
}
