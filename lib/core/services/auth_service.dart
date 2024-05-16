import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:authorization/core/services/statistics_weight_service.dart';
import 'package:authorization/core/services/workout_create_service.dart';
import 'package:authorization/core/services/workout_performing_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User> signUp(String email, String password, String name) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    final User user = result.user!;
    await user.updateDisplayName(name);

    await registerUserInDatabase(email, name);

    return user;
  }

  static Future<bool> registerUserInDatabase(String email, String name) async {
    await GetIt.I<WorkoutCreateService>().updateUserWorkoutsLastId(1000);
    await GetIt.I<WorkoutPerformingService>().updateIsTrainingInProgress(false);
    await GetIt.I<WorkoutPerformingService>().updateLastWorkoutInHistory(0);
    await GetIt.I<StatisticsWeightServise>().setMinWeight(1000);
    await GetIt.I<StatisticsWeightServise>().setMaxWeight(0);

    await GetIt.I<ChatService>().setUserId();
    await GetIt.I<ChatService>().setUserEmail(email);
    await GetIt.I<ChatService>().setDisplayName(name);

    return true;
  }

  static Future<User> verificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();

    return user;
  }

  static Future resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = result.user;

      if (user == null) {
        throw Exception("User not found");
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}

String getExceptionMessage(FirebaseAuthException e) {
  print(e.code);
  switch (e.code) {
    case 'user-not-found':
      return 'User not found';
    case 'wrong-password':
      return 'Password is incorrect';
    case 'requires-recent-login':
      return 'Log in again before retrying this request';
    default:
      return e.message ?? 'Error';
  }
}
