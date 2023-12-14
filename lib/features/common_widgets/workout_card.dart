import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
    this.onLongPress,
  });

  final Workout workout;

  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(workout.imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            width: double.infinity,
            height: 85,
            padding: const EdgeInsets.only(
              top: 8,
              left: 14,
              right: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _createData(),
                workout.isComplete
                    ? const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Complete: date",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );

    // return InkWell(
    //   onTap: () {
    //     BlocProvider.of<SearchScreenBloc>(context)
    //         .add(WorkoutDetailsTapped(workout: workout));
    //   },
    //   child: Container(
    //     width: double.infinity,
    //     height: 100,
    //     padding: const EdgeInsets.only(
    //       top: 8,
    //       left: 14,
    //       right: 14,
    //     ),
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage("assets/${workout.imageUrl}"),
    //         fit: BoxFit.cover,
    //       ),
    //       color: Colors.purple,
    //       borderRadius: const BorderRadius.all(Radius.circular(20)),
    //     ),
    //     child: _createData(),
    //   ),
    // );
  }

  Widget _createData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          workout.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          "${workout.minutesWorkoutTime} MIN. · ${workout.exercises.length} EXERCISES",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
