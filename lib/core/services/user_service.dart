import 'package:authorization/core/services/auth_service.dart';
import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class UserService {
  static final FirebaseAuth firebase = FirebaseAuth.instance;

  static Future<bool> editPhoto(String photoUrl) async {
    try {
      await firebase.currentUser?.updatePhotoURL(photoUrl);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> changeUserData(
      {required String displayName, required String email}) async {
    try {
      await firebase.currentUser?.updateDisplayName(displayName);
      await firebase.currentUser?.updateEmail(email);

      await GetIt.I<ChatService>().setUserEmail(email);
      await GetIt.I<ChatService>().setDisplayName(displayName);

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> changePassword({required String newPass}) async {
    try {
      await firebase.currentUser?.updatePassword(newPass);
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await firebase.signOut();
  }
}
