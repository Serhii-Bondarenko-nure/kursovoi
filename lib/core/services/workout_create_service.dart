import 'dart:convert';

import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class WorkoutCreateService {
  WorkoutCreateService({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late final userRef = firebaseDatabase.ref("users/$currentUserUid");
  late final userWorkoutsRef = userRef.child("workouts");
  late final workoutCreateRef = userRef.child("workoutCreationData");
  late final workoutCreateExercises = workoutCreateRef.child("exercises");

  late final workoutsRef = firebaseDatabase.ref("serviceData/workouts");

  //Получение данных

  Future<Workout> getWorkoutCreationData() async {
    try {
      final snapshot = await workoutCreateRef.get();
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
            exercises: workout.exercises[0]!.id == 0
                ? {}
                : Map.fromEntries(workout.exercises.entries.toList()
                  ..sort((e1, e2) => e1.key.compareTo(e2.key))),
            minutesWorkoutTime: workout.minutesWorkoutTime,
            lastComplete: workout.lastComplete);

        return workoutData;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return const Workout(
      id: 0,
      imageUrl: "",
      isComplete: false,
      isUserOwner: false,
      name: "",
      types: [],
      descriptions: [],
      exercises: {},
      minutesWorkoutTime: 0,
      lastComplete: null,
    );
  }

  //Первоначальная установка

  Future<bool> setSimpleWorkoutCreationData() async {
    try {
      await workoutCreateRef.set({
        "descriptions": [""],
        "exercisesNumber": 0,
        "exercises": {
          "ex0": {
            "exerciseTime": 0,
            "gifUrl": "",
            "id": "0000",
            "name": "",
            "repetitions": 0,
            "sets": 0,
            "target": ""
          },
        },
        "id": await getUserWorkoutsLastId(),
        "imageUrl": "",
        "isComplete": false,
        "isUserOwner": true,
        "minutesWorkoutTime": 0,
        "name": "",
        "types": ["User"]
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> setChangeWorkoutCreationData(int id) async {
    try {
      DataSnapshot snapshot;

      id >= 1000
          ? snapshot = await userWorkoutsRef.child("id$id").get()
          : snapshot = await workoutsRef.child("id$id").get();

      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        final workout = Workout.fromJson(data);

        var types = workout.types;
        types.add("User");
        var typesMap = types.asMap();

        await workoutCreateRef.remove();

        await userRef.update({"workoutCreationData": snapshot.value});
        await workoutCreateRef.update({"types": typesMap});
        await workoutCreateRef.update({"isUserOwner": true});
        await workoutCreateRef
            .update({"exercisesNumber": workout.exercises.length});
      }

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> setCopyWorkoutCreationData(int id) async {
    try {
      await setChangeWorkoutCreationData(id);
      final newId = await getUserWorkoutsLastId();
      await workoutCreateRef.update({"id": newId});
      final snapshot = await workoutCreateRef.child("name").get();
      if (snapshot.exists) {
        final data = snapshot.value as String;
        await workoutCreateRef.update({"name": "$data (Copy)"});

        return true;
      }

      return false;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Работа с полем id последней тренировки

  Future<bool> updateUserWorkoutsLastId(int id) async {
    try {
      await userRef.update({
        "userWorkoutsLastId": id,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<int> getUserWorkoutsLastId() async {
    int id = 0;
    try {
      final snapshot = await userRef.child("userWorkoutsLastId").get();
      if (snapshot.exists) {
        id = snapshot.value as int;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return id;
  }

  //Для самого создания тренировки

  Future<bool> createEmptyExerciseData(Exercise exercise) async {
    int exercisesNumber = 0;
    try {
      final snapshot = await workoutCreateRef.child("exercisesNumber").get();
      if (snapshot.exists) {
        exercisesNumber = snapshot.value as int;

        final exerciseCard = ExerciseCard(
            exerciseTime: 0,
            gifUrl: exercise.gifUrl,
            id: exercise.id,
            name: exercise.name,
            sets: 0,
            repetitions: 0,
            target: exercise.target);

        await workoutCreateExercises
            .update({"ex$exercisesNumber": exerciseCard.toJson()});

        await _exercisesNumberPlusMinus(true);

        return true;
      }
      return false;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> updateExerciseDataById(
    int exercisesNumber,
    int sets,
    int repetitions,
  ) async {
    try {
      await workoutCreateExercises.child("ex$exercisesNumber").update({
        "repetitions": repetitions,
        "sets": sets,
      });
      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> deleteExerciseData(int exercisesNumber) async {
    try {
      await workoutCreateExercises.child("ex$exercisesNumber").remove();
      await _exercisesNumberPlusMinus(false);

      final snapshot = await workoutCreateExercises.get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;

        //получил карту и привел в нормальный вид
        final exericesMap = data.map((key, value) => MapEntry(
            int.parse(key.replaceAll(RegExp('[^0-9]'), '')),
            ExerciseCard.fromJson(value)));

        //отсортировал карту
        final exerices = Map.fromEntries(exericesMap.entries.toList()
          ..sort((e1, e2) => e1.key.compareTo(e2.key)));

        //привел к списку, чтобы обнулить ключи и обратно к карте чтобы снова их проставить
        //порядок упражнений соблюден
        final exericesToJson = exerices.values.toList().asMap();

        //преобразовал в json
        final exericesReturn = exericesToJson
            .map((key, value) => MapEntry("ex$key", value.toJson()));

        //обновил данные
        await workoutCreateExercises.remove();
        await workoutCreateRef.update({"exercises": exericesReturn});

        return true;
      }

      return false;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> updateWorkoutName(String name) async {
    try {
      await workoutCreateRef.update({"name": name});
      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> changeExercisesPositions() async {
    try {
      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Это служебный метод для добавления упражнений//
  Future<bool> _exercisesNumberPlusMinus(bool plusMinus) async {
    int exercisesNumber;
    try {
      final snapshot = await workoutCreateRef.child("exercisesNumber").get();
      if (snapshot.exists) {
        exercisesNumber = snapshot.value as int;
        await workoutCreateRef.update({
          "exercisesNumber": plusMinus ? ++exercisesNumber : --exercisesNumber
        });
        return true;
      }

      return false;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Создание тренировки
}
