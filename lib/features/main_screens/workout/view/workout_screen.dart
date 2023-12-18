import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/core/services/workouts_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:authorization/features/main_screens/workout/bloc/workout_bloc.dart';
import 'package:authorization/features/main_screens/workout/widgets/workout_content.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});

  final workoutBloc =
      WorkoutBloc(userWorkoutsService: GetIt.I<WorkoutsUserService>())
        ..add(LoadWorkoutsList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.workoutsIcon)),
        automaticallyImplyLeading: false,
      ),
      body: _createBody(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: SizedBox(
          width: 58,
          height: 58,
          child: FloatingActionButton(
            backgroundColor: ColorConstants.primaryColor,
            onPressed: () async {
              workoutBloc.add(WorkoutCreateTapped());
            },
            tooltip: 'Create',
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.add,
              size: 38,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createBody(context) {
    return BlocProvider<WorkoutBloc>(
        create: (context) => workoutBloc,
        child: BlocListener<WorkoutBloc, WorkoutState>(
          listener: (context, state) {
            if (state is NextWorkoutDetailsPage) {
              AutoRouter.of(context)
                  .push(WorkoutDetailsRoute(
                    workoutId: state.workoutId,
                    isSearchScreen: false,
                  ))
                  .then((result) => workoutBloc.add(LoadWorkoutsList()));
            } else if (state is NextCreateWorkoutPage) {
              AutoRouter.of(context)
                  .push(WorkoutCreateRoute())
                  .then((result) => workoutBloc.add(LoadWorkoutsList()));
            } else if (state is NextReloadedState) {
              workoutBloc.add(LoadWorkoutsList());
            } else if (state is WorkoutErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exeption.toString())));
            }
          },
          child: WorkoutContent(),
        ));
  }
}
