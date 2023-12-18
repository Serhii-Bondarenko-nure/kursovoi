import 'dart:convert';
import 'dart:ffi';

import 'package:authorization/core/repositories/workouts/models/exercise_card.dart';
import 'package:authorization/core/repositories/workouts/models/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class WorkoutPerformingService {
  WorkoutPerformingService({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late final userRef = firebaseDatabase.ref("users/$currentUserUid");
  late final userWorkoutsRef = userRef.child("workouts");
  late final workoutPerformingRef = userRef.child("workoutPerformingData");
  late final exercisesFlagsRef = workoutPerformingRef.child("exercisesFlags");

  //Получение данных
  //Также вызвать метод getExercisesFlags

  Future<Workout> getWorkoutPerformingData() async {
    try {
      final snapshot = await workoutPerformingRef.get();
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

  Future<bool> setWorkoutPerformingData(Workout workout) async {
    try {
      await userRef.update({
        "workoutPerformingData": workout.toJson(),
      });
      await updateIsTrainingInProgress(true);
      await setExercisesFlags(workout.exercises);
      await workoutPerformingRef.update({
        "workoutStart": DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Методы работы с флагами выполнения подхода

  Future<Map<int, Map<int, bool>>> getAllExercisesFlags() async {
    try {
      Map<int, Map<int, bool>> exercisesFlags = {};

      final snapshot = await workoutPerformingRef.child("exercisesFlags").get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;

        final dataList = data.values.toList();
        for (var i = 0; i < dataList.length; i++) {
          final Map<int, bool> exercisesSetsFlags = {};
          final dataMap = dataList[i] as Map<String, dynamic>;
          final flagsList = dataMap.values.toList();

          for (var j = 0; j < dataMap.length; j++) {
            exercisesSetsFlags[j] = flagsList[j] as bool;
          }

          exercisesFlags[i] = exercisesSetsFlags;
        }
      }

      return exercisesFlags;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return {};
  }

  Future<Map<int, bool>> getExerciseFlagsByExerciseNumber(
      int exerciseNumber) async {
    try {
      Map<int, bool> exerciseFlags = {};

      final snapshot = await exercisesFlagsRef.child("ex$exerciseNumber").get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;

        //final flagsList = data.values.toList();
        for (var j = 0; j < data.length; j++) {
          exerciseFlags[j] = data["set$j"] as bool;
        }
      }
      return exerciseFlags;
      // return Map.fromEntries(exerciseFlags.entries.toList()
      //   ..sort((e1, e2) => e1.key.compareTo(e2.key)));
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return {};
  }

  Future<bool> setExercisesFlags(Map<int, ExerciseCard> exerciseCards) async {
    try {
      Map<String, Map<String, bool>> exercisesFlagsMap = {};

      final exercisesList = exerciseCards.values.toList();
      final exercisesSetsList = <int>[];
      for (var i = 0; i < exercisesList.length; i++) {
        exercisesSetsList.add(exercisesList[i].sets);
      }

      for (var i = 0; i < exercisesSetsList.length; i++) {
        final Map<String, bool> execrisesSetsNumber = {};
        for (var j = 0; j < exercisesSetsList[i]; j++) {
          execrisesSetsNumber["set$j"] = false;
        }
        exercisesFlagsMap["ex$i"] = execrisesSetsNumber;
      }

      // exercisesFlagsMap.map((key, value) => MapEntry(
      //     int.parse(key.replaceAll(RegExp('[^0-9]'), '')),
      //     SingleExerciseFlags.fromJson(value)));

      //exercisesFlagsMap.map((key, value) => MapEntry("ex$key", value.toJson()));

      await workoutPerformingRef.update({
        "exercisesFlags": exercisesFlagsMap,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> updateExerciseFlagByExerciseNumberAndSetNumber(
      int exerciseNumber, int setNumber, bool flag) async {
    try {
      await exercisesFlagsRef.child("ex$exerciseNumber").update({
        "set$setNumber": flag,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> getWorkoutIsCompleteTrue() async {
    bool isComplete = true;
    try {
      final exercisesFlags = await getAllExercisesFlags();

      final dataList = exercisesFlags.values.toList();
      for (var i = 0; i < dataList.length; i++) {
        final flagsList = dataList[i].values.toList();

        for (var j = 0; j < flagsList.length; j++) {
          if (flagsList[j] == false) {
            isComplete = false;
          }
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return isComplete;
  }

  //Работа с полем isTrainingInProgress

  Future<bool> updateIsTrainingInProgress(bool isTrainingInProgress) async {
    try {
      await userRef.update({
        "isTrainingInProgress": isTrainingInProgress,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  Future<bool> getIsTrainingInProgress() async {
    try {
      final snapshot = await userRef.child("isTrainingInProgress").get();
      if (snapshot.exists) {
        return snapshot.value as bool;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }

    return false;
  }

  //Обновление поля lastComplete и isComplete

  //Обновляет в тренировках пользователя
  Future<bool> updateLastCompleteInUserWorkouts(int workoutId) async {
    try {
      await userWorkoutsRef.child("id$workoutId").update({
        "lastComplete": DateTime.now().toIso8601String(),
        "isComplete": true,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  //Обновляет в текущем объекте для сбора данных в статистику
  Future<bool> updateLastCompleteInWorkoutPerforming() async {
    try {
      await workoutPerformingRef.update({
        "lastComplete": DateTime.now().toIso8601String(),
        "isComplete": true,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }
}
