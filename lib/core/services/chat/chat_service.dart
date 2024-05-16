import 'dart:convert';

import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ChatService {
  ChatService({
    required this.firebaseDatabase,
  });

  final FirebaseDatabase firebaseDatabase;
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  late final usersRef = firebaseDatabase.ref("chat/users");
  late final userRef = usersRef.child(currentUserUid);

  //Список пользователей
  Future<List<UserChatModel>> getUsersList() async {
    var users = List<UserChatModel>.empty();

    try {
      final snapshot = await usersRef.get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        users =
            data.values.map((item) => UserChatModel.fromJson(item)).toList();

        return users;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }

    return users;
  }

  //Запись id
  Future<bool> setUserId() async {
    try {
      await userRef.update({
        "id": currentUserUid,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  // Future<String> getUserId() async {
  //   String id = '';
  //   try {
  //     final snapshot = await userRef.child("id").get();
  //     if (snapshot.exists) {
  //       id = snapshot.value as String;
  //     }
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //   }
  //   return id;
  // }

  //Запись email
  Future<bool> setUserEmail(String email) async {
    try {
      await userRef.update({
        "email": email,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

  // Future<String> getUserEmail() async {
  //   String email = '';
  //   try {
  //     final snapshot = await userRef.child("email").get();
  //     if (snapshot.exists) {
  //       email = snapshot.value as String;
  //     }
  //   } catch (e, st) {
  //     GetIt.I<Talker>().handle(e, st);
  //   }
  //   return email;
  // }

//Запись username
  Future<bool> setDisplayName(String displayName) async {
    try {
      await userRef.update({
        "displayName": displayName,
      });

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }
}
