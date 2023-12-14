import 'dart:convert';
import 'dart:math';

import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/core/repositories/workouts/workouts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class UserWorkoutsFirebaseRealtimeDatabaseService {
  UserWorkoutsFirebaseRealtimeDatabaseService({
    //required this.userWorkoutsBox,
    required this.firebaseDatabase,
  });

  //final Box<Workout> userWorkoutsBox;
  final FirebaseDatabase firebaseDatabase;

  final workoutsRepository = GetIt.I<AbstractWorkoutsRepository>();
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

        return workout;
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
      exercises: const [],
      minutesWorkoutTime: 0,
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

  Future<int> getUserWorkoutsLstId() async {
    int id = 0;
    try {
      final snapshot = await userRef.child("userWorkoutsLastId").get();
      id = snapshot.value as int;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return id;
  }

  //временно, для нужд разработки
  //Загрузить упражнения пользователю
  //Ограничить количество упражнений для добавления
  Future<bool> developmentSetWorkoutsList() async {
    final workoutsList = await workoutsRepository.getWorkoutsList();

    final userWorkoutsList = workoutsList.map((workout) {
      var types = <String>[];
      types.addAll(workout.types);
      types.add("User");
      return Workout(
        id: workout.id,
        imageUrl: workout.imageUrl,
        isComplete: workout.isComplete,
        isUserOwner: true,
        name: "User${workout.name}",
        types: types,
        descriptions: workout.descriptions,
        exercises: workout.exercises,
        minutesWorkoutTime: workout.minutesWorkoutTime,
      );
    }).toList();

    for (var i = 0; i < 5; i++) {
      await workoutsRef.update({
        "id${workoutsList[i].id}": userWorkoutsList[i].toJson(),
      });
    }

    // for (var element in workoutsList) {
    //   await workoutsRef.update({
    //     "${element.id}": element.toJson(),
    //   });
    // }

    return true;
  }

  //Создание упражнений, для нужд разработки
  Future<bool> developmentCreateWorkoutsList() async {
    var workoutsList = <Workout>[];

    final typesList = await workoutsRepository
        .getTypesList()
        .then((value) => value.typesList);
    final exersicesList = await exercisesReporitory.getExercisesList();

    // final workoutsByTypesList = List.generate(
    //     typesList.length, (index) => Random(index * 2 + 12).nextInt(4) + 5);

    final workoutsByTypesList = [8, 4, 3, 6];
    int id = 0;

    for (var i = 0; i < workoutsByTypesList.length; i++) {
      for (var j = 0; j < workoutsByTypesList[i]; j++) {
        final exercisesToWorkout = <ExerciseCard>[];

        for (var k = 0; k < Random().nextInt(4) + 3; k++) {
          final index = Random().nextInt(1324);
          exercisesToWorkout.add(
            ExerciseCard(
              exerciseTime: 0,
              gifUrl: exersicesList[index].gifUrl,
              id: exersicesList[index].id,
              name: exersicesList[index].name,
              sets: Random().nextInt(2) + 2,
              repetitions: Random().nextInt(5) + 8,
              target: exersicesList[index].target,
            ),
          );
        }

        workoutsList.add(Workout(
          id: id,
          imageUrl: 'assets/icons/workouts/3.0x/pilates.png',
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
        ));
        id++;
      }
    }

    final workoutsListJson =
        (workoutsList.map((item) => item.toJson()).toList());

    try {
      await firebaseDatabase.ref('development').update({
        "createWorkoutsList": workoutsListJson,
      });

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
