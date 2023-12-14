class ExercisesReporitoryConstants {
  //Base URL
  static const String baseUrl = 'https://exercisedb.p.rapidapi.com';

  //Base Options
  static const sendTimeout = Duration(seconds: 5);
  static const connectTimeout = Duration(seconds: 3);
  static const receiveTimeout = Duration(seconds: 3);

  //Headers
  static const Map<String, String> headers = {
    "X-RapidAPI-Key": "05287cf427msh80ead621be0569ap1c3bcajsn5493efe72163",
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
