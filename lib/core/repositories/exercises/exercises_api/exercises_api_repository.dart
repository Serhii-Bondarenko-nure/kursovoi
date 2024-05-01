import 'package:authorization/core/constants/exercises_reporitory_constants.dart';
import 'package:authorization/core/repositories/exercises/exercises_api/abstract_exercises_api_repository.dart';
import 'package:authorization/core/repositories/exercises/models/body_parts.dart';
import 'package:authorization/core/repositories/exercises/models/equipment.dart';
import 'package:authorization/core/repositories/exercises/models/exercise.dart';
import 'package:authorization/core/repositories/exercises/models/target_muscles.dart';
import 'package:dio/dio.dart';

class ExersicesApiRepository implements AbstractExersicesApiRepository {
  ExersicesApiRepository({required this.dio});

  final Dio dio;

  //Exercises List
  @override
  Future<List<Exercise>> fetchExercisesListFromApi() async {
    final response = await dio.get(
      ExercisesReporitoryConstants.exercisesEndPoint,
      queryParameters: {
        'limit': ExercisesReporitoryConstants.allExercisesLimit
      },
    );

    final data = response.data as List<dynamic>;
    var exercisesList = (data.map((item) => Exercise.fromJson(item)).toList());

    return exercisesList;
  }

  //Target Muscles, Equipment, BodyParts Lists
  @override
  Future<TargetMuscles> fetchTargetMusclesListFromApi() async {
    final response =
        await dio.get(ExercisesReporitoryConstants.targetListEndPoint);

    final targetMuscles = TargetMuscles(
        targetMusclesList: _listsFromJsonCategories(response.data));

    return targetMuscles;
  }

  @override
  Future<Equipment> fetchEquipmentListFromApi() async {
    final response =
        await dio.get(ExercisesReporitoryConstants.equipmentListEndPoint);

    final equipment =
        Equipment(equipmentList: _listsFromJsonCategories(response.data));

    return equipment;
  }

  @override
  Future<BodyParts> fetchBodyPartsListFromApi() async {
    final response =
        await dio.get(ExercisesReporitoryConstants.bodyPartListEndPoint);

    final bodyParts =
        BodyParts(bodyPartsList: _listsFromJsonCategories(response.data));

    return bodyParts;
  }

  List<String> _listsFromJsonCategories(dynamic responseData) {
    final data = responseData as List<dynamic>;

    final stringList = data.map((item) => item as String).toList();

    return stringList;
  }

  //Exercise by id, name
  @override
  Future<Exercise> fetchExerciseByIdFromApi(int exerciseId) async {
    final response = await dio.get(
        "${ExercisesReporitoryConstants.exercisebyIdEndPointEndPoint}${_idToJson(exerciseId)}");

    final data = response.data as Map<String, dynamic>;
    final exercise = Exercise.fromJson(data);

    return exercise;
  }

  String _idToJson(int id) {
    String idToString = "";
    for (var i = 0; i < 4 - "$id".length; i++) {
      idToString += "0";
    }
    String idString = "$idToString$id";
    return idString;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByNameFromApi(
      String exerciseName) async {
    final response = await dio.get(
      "${ExercisesReporitoryConstants.exercisesListbyNameEndPoint}$exerciseName",
      queryParameters: {
        'limit': ExercisesReporitoryConstants.exercisesByNameLimit
      },
    );

    final exercisesList = _exercisesListsFromJson(response);

    return exercisesList;
  }

  //Exercises Lists by Target Muscles, Equipment, BodyParts
  @override
  Future<List<Exercise>> fetchExercisesListByTargetMuscleFromApi(
      String targetMuscle) async {
    final response = await dio.get(
      "${ExercisesReporitoryConstants.exercisesListByTargetMuscleEndPoint}$targetMuscle",
      queryParameters: {
        'limit':
            ExercisesReporitoryConstants.exercisesByEquipmentTargetBodyPartLimit
      },
    );

    final exercisesList = _exercisesListsFromJson(response);

    return exercisesList;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByEquipmentTypeFromApi(
      String equipmentType) async {
    final response = await dio.get(
      "${ExercisesReporitoryConstants.exercisesListByEquipmentEndPoint}$equipmentType",
      queryParameters: {
        'limit':
            ExercisesReporitoryConstants.exercisesByEquipmentTargetBodyPartLimit
      },
    );

    final exercisesList = _exercisesListsFromJson(response);

    return exercisesList;
  }

  @override
  Future<List<Exercise>> fetchExercisesListByBodyPartFromApi(
      String bodyPart) async {
    final response = await dio.get(
      "${ExercisesReporitoryConstants.exercisesListByBodyPartEndPoint}$bodyPart",
      queryParameters: {
        'limit':
            ExercisesReporitoryConstants.exercisesByEquipmentTargetBodyPartLimit
      },
    );

    final exercisesList = _exercisesListsFromJson(response);

    return exercisesList;
  }

  List<Exercise> _exercisesListsFromJson(Response<dynamic> response) {
    final data = response.data as List<dynamic>;

    var exercisesList = (data.map((item) => Exercise.fromJson(item)).toList());

    return exercisesList;
  }
}
