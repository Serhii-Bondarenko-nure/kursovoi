import 'dart:convert';

import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/core/repositories/workouts/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class WorkoutsUserService {
  WorkoutsUserService({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;

  final exercisesReporitory = GetIt.I<AbstractExersicesRepository>();
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late final userRef = firebaseDatabase.ref("users/$currentUserUid");
  late final workoutsRef = userRef.child("/workouts");

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

  Future<bool> updateWorkoutIsCompleteFieldById(
      int workoutId, bool isComplete) async {
    try {
      await workoutsRef.update({
        "id$workoutId/isComplete": isComplete,
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

  // **************************************************************************
  //Метод получения списка тренировок с локального хранилища
  //Заготовка на будущее для улучшения производительности
  //Сделать такой же и для карточек
  //Логика
  //В try catch получит данные с локального хранилища
  //Если пустое кинет ошибку и перехватит толкер
  //В catch просто запрос к Firebase RealtimeDatabase
  //И запись в переменную для возврата и уже из нее в локальное хранилище
  //Возвращает переменную
  // Future<List<WorkoutCard>> getWorkoutListFromLocalRealtimeDatabase(){}
  // **************************************************************************

  // **************************************************************************
  //Метод для получения карточки тренировки
  //На будущее, может нужно будет
  //Создать модель WorkoutCard с полями id, imageUrl, name
  //В сервис
  //Future<List<WorkoutCard>> getWorkoutCardsListFromFirebaseRealtimeDatabase(){}
  //В репозиторий
  //@override
  //Future<List<WorkoutCard>> getWorkoutCardsList (){}
  //Future<List<WorkoutCard>> _fetchWorkoutCardsListFromLocalJson (){}
  // **************************************************************************

  // **************************************************************************
  //Совсем на будущее
  //Можно ещё сделать тип тренировка дня, но там нужно логику с рандом сложную. Или найти библиотеку. Тип тренировка, которая уже была получает меньший приоритет, а которая давно не была большой. Ну и так как-то.
  //И можно ещё сделать, что зайдя на карточку тренировки можно сделать кнопку, которая позволяет скопировать ее содержимое в свой редактор. И изменить как хочешь, и сохранить в пользовательские тренировки.
  //Ну и ещё тогда можно будет какую-то логику, что только со стандартными тренировками можно такое сделать. Хз, идеи на будущее, сначала основное.
  // **************************************************************************
}
