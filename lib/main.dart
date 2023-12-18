import 'package:authorization/core/consts/exercises_reporitory_constants.dart';
import 'package:authorization/core/consts/hive_constants.dart';
import 'package:authorization/core/repositories/exercises/exercises.dart';
import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:authorization/core/services/workouts_service.dart';
import 'package:authorization/core/services/workouts_user_service.dart';
import 'package:authorization/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'fitness_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Talker
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  //Firebase
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  talker.info(app.options.projectId);

  //Firebase Database
  final firebaseDatabase = FirebaseDatabase.instanceFor(
    app: app,
    databaseURL:
        'https://authorization-8fd62-default-rtdb.europe-west1.firebasedatabase.app/',
  );
  firebaseDatabase.setPersistenceEnabled(true);

  //Bloc
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  //Dio
  final dio = Dio(BaseOptions(
    sendTimeout: ExercisesReporitoryConstants.sendTimeout,
    connectTimeout: ExercisesReporitoryConstants.connectTimeout,
    receiveTimeout: ExercisesReporitoryConstants.receiveTimeout,
    baseUrl: ExercisesReporitoryConstants.baseUrl,
    headers: ExercisesReporitoryConstants.headers,
  ));

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  //Hive
  await Hive.initFlutter();

  //Exercises Hive
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(TargetMusclesAdapter());
  Hive.registerAdapter(EquipmentAdapter());
  Hive.registerAdapter(BodyPartsAdapter());

  final exercisesBox =
      await Hive.openBox<Exercise>(NamesHiveConstants.exercisesBoxName);
  final targetMusclesBox = await Hive.openBox<TargetMuscles>(
      NamesHiveConstants.targetMusclesBoxName);
  final equipmentBox =
      await Hive.openBox<Equipment>(NamesHiveConstants.equipmentBoxName);
  final bodyPartsBox =
      await Hive.openBox<BodyParts>(NamesHiveConstants.bodyPartsBoxName);

  // //Workouts Hive
  // Hive.registerAdapter(WorkoutAdapter());
  // Hive.registerAdapter(ExerciseCardAdapter());
  // Hive.registerAdapter(TypesAdapter());

  // final workoutBox =
  //     await Hive.openBox<Workout>(NamesHiveConstants.workoutsBoxName);
  // final exerciseCardBox =
  //     await Hive.openBox<ExerciseCard>(NamesHiveConstants.exerciseCardsBoxName);
  // final typesBox = await Hive.openBox<Types>(NamesHiveConstants.typesBoxName);

  // final userWorkoutsBox =
  //     await Hive.openBox<Workout>(NamesHiveConstants.userWorkoutsBoxName);

  //Exercises Repository
  final exersicesApiRepository = ExersicesApiRepository(dio: dio);
  final exersicesBackupRepository = ExersicesBackupRepository();

  GetIt.I.registerLazySingleton<AbstractExersicesRepository>(
      () => ExersicesRepository(
            exersicesApiRepository: exersicesApiRepository,
            exersicesBackupRepository: exersicesBackupRepository,
            exercisesBox: exercisesBox,
            targetMusclesBox: targetMusclesBox,
            equipmentBox: equipmentBox,
            bodyPartsBox: bodyPartsBox,
            isApiEnable: false,
          ));

  // //Workouts Repository
  // GetIt.I.registerLazySingleton<AbstractWorkoutsRepository>(
  //   () => WorkoutsRepository(
  //     workoutBox: workoutBox,
  //     exerciseCardBox: exerciseCardBox,
  //     typesBox: typesBox,
  //   ),
  // );

  //Workouts Service
  GetIt.I.registerLazySingleton<WorkoutsService>(
    () => WorkoutsService(
      firebaseDatabase: firebaseDatabase,
    ),
  );

  //User Workouts Service
  GetIt.I.registerLazySingleton<WorkoutsUserService>(
    () => WorkoutsUserService(
      firebaseDatabase: firebaseDatabase,
    ),
  );

  //Workout Create Service
  GetIt.I.registerLazySingleton<WorkoutCreateService>(
    () => WorkoutCreateService(
      firebaseDatabase: firebaseDatabase,
    ),
  );

  //Workout Performing Service
  GetIt.I.registerLazySingleton<WorkoutPerformingService>(
    () => WorkoutPerformingService(
      firebaseDatabase: firebaseDatabase,
    ),
  );

  //Statistics Service
  GetIt.I.registerLazySingleton<StatisticsWeightServise>(
    () => StatisticsWeightServise(
      firebaseDatabase: firebaseDatabase,
    ),
  );

  // **************************************************************************
  //Возможно сервисы тоже буду добавлять через Get It
  // **************************************************************************

  //Сatch other errors
  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runApp(const FitnessApp());
}
