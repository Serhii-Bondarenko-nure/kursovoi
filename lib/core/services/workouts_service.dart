import 'dart:convert';
import 'dart:math';

import 'package:authorization/core/repositories/exercises/abstract_exercises_repository.dart';
import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class WorkoutsService {
  WorkoutsService({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;

  final exercisesReporitory = GetIt.I<AbstractExersicesRepository>();

  late final serviceDataRef = firebaseDatabase.ref("serviceData");
  late final workoutsRef = serviceDataRef.child("/workouts");
  late final typesRef = serviceDataRef.child("/types");

  Future<List<Workout>> getWorkoutsList() async {
    var workoutsList = <Workout>[];

    try {
      final snapshot = await workoutsRef.get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        workoutsList = data.values.map((item) {
          return Workout.fromJson(item);
        }).toList();
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return workoutsList;
  }

  Future<Types> getTypesList() async {
    try {
      final snapshot = await typesRef.get();
      if (snapshot.exists) {
        final data = jsonDecode(jsonEncode(snapshot.value)) as List<dynamic>;
        final typesList = data.map((item) => item as String).toList();
        final types = Types(typesList: typesList);
        return types;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return const Types(typesList: []);
  }

  Future<Workout> getWorkoutById(int id) async {
    //Workout workout;

    try {
      final snapshot = await workoutsRef.child("id$id").get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        final workout = Workout.fromJson(data);

        final workoutData = Workout(
            id: workout.id,
            imageUrl: workout.imageUrl,
            isComplete: workout.isComplete,
            isUserOwner: workout.isUserOwner,
            name: workout.name,
            types: workout.types,
            descriptions: workout.descriptions,
            exercises: Map.fromEntries(workout.exercises.entries.toList()
              ..sort((e1, e2) => e1.key.compareTo(e2.key))),
            minutesWorkoutTime: workout.minutesWorkoutTime,
            lastComplete: workout.lastComplete);

        return workoutData;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return Workout(
      id: id,
      imageUrl: "",
      isComplete: false,
      isUserOwner: false,
      name: "",
      types: const [],
      descriptions: const [],
      exercises: const {},
      minutesWorkoutTime: 0,
      lastComplete: null,
    );
  }

  Future<List<Workout>> getWorkoutsListByType(String workoutType) async {
    final workouts = await getWorkoutsList();

    final workoutsList =
        workouts.where((item) => item.types.contains(workoutType)).toList();

    return workoutsList;
  }

  //Для нужд разработки
  Future<bool> updateWorkoutById(Workout workout) async {
    try {
      await workoutsRef.update({
        "id${workout.id}": workout.toJson(),
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> deleteWorkoutById(int workoutId) async {
    try {
      await workoutsRef.child("id$workoutId").remove();

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> developmentCreateWorkoutsList() async {
    var workoutsList = <Workout>[];

    final typesList = (await getTypesList()).typesList;
    final exersicesList = await exercisesReporitory.getExercisesList();

    final workoutsByTypesList = [8, 4, 3, 6];
    int id = 0;

    for (var i = 0; i < workoutsByTypesList.length; i++) {
      for (var j = 0; j < workoutsByTypesList[i]; j++) {
        var exercisesToWorkout = <int, ExerciseCard>{};

        for (var k = 0; k < Random().nextInt(4) + 3; k++) {
          final index = Random().nextInt(1324);
          exercisesToWorkout[k] = ExerciseCard(
            exerciseTime: 0,
            gifUrl: exersicesList[index].gifUrl,
            id: exersicesList[index].id,
            name: exersicesList[index].name,
            sets: Random().nextInt(2) + 2,
            repetitions: Random().nextInt(5) + 8,
            target: exersicesList[index].target,
          );
        }

        workoutsList.add(Workout(
          id: id,
          imageUrl:
              'https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1024-512,f_auto,q_auto:best/newscms/2017_49/2252701/kettlebell.jpg',
          isComplete: false,
          isUserOwner: false,
          name: "Workout$id",
          types: [typesList[i]],
          descriptions: const [
            "Here is a description of this workout.",
            "I don't know how long it will be, but it will be long enough.",
            "But I'm sure it will be satisfactory.",
          ],
          exercises: exercisesToWorkout,
          minutesWorkoutTime: Random().nextInt(21) + 4,
          lastComplete: null,
        ));
        id++;
      }
    }

    try {
      for (var i = 0; i < workoutsList.length; i++) {
        await workoutsRef.update({
          "id${workoutsList[i].id}": workoutsList[i].toJson(),
        });
      }

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }
}
