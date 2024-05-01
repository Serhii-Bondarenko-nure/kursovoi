class ExercisesReporitoryConstants {
  //Base URL
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';

  //Base Options
  static const sendTimeout = Duration(seconds: 5);
  static const connectTimeout = Duration(seconds: 3);
  static const receiveTimeout = Duration(seconds: 3);

  //Headers
  static const Map<String, String> headers = {
    "X-RapidAPI-Key": "7a1118f2dfmsh84cca89f44f7ee8p1df3bdjsn5532cc0b495d",
    "X-RapidAPI-Host": "exercisedb.p.rapidapi.com",
  };

  //End Points
  static const String exercisesEndPoint = '/exercises';
  static const String targetListEndPoint = '/exercises/targetList';
  static const String equipmentListEndPoint = '/exercises/equipmentList';
  static const String bodyPartListEndPoint = '/exercises/bodyPartList';
  static const String exercisebyIdEndPointEndPoint = '/exercises/exercise/';
  static const String exercisesListbyNameEndPoint = '/exercises/name/';
  static const String exercisesListByEquipmentEndPoint =
      '/exercises/equipment/';
  static const String exercisesListByTargetMuscleEndPoint =
      '/exercises/target/';
  static const String exercisesListByBodyPartEndPoint = '/exercises/bodyPart/';

  //Query Parameters
  static const int allExercisesLimit = 1500;
  static const int exercisesByNameLimit = 1000;
  static const int exercisesByEquipmentTargetBodyPartLimit = 500;
}
