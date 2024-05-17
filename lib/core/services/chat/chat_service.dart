import 'dart:convert';

import 'package:authorization/core/services/chat/message_model.dart';
import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  late final chatRoomsRef = firebaseDatabase.ref("chat/chatsRooms");

  //Список пользователей
  Future<List<UserChatModel>> getUsersList() async {
    var users = List<UserChatModel>.empty(growable: true);

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

// send message
  Future<bool> SendMessage(String receiverId, String messageText) async {
    try {
      var time = DateTime.now();
      var messagesNumber = 0;
      final message = MessageModel(
        senderId: currentUserUid,
        senderEmail: FirebaseAuth.instance.currentUser!.email!,
        receiverId: receiverId,
        message: messageText,
        time: time,
      );

      var ids = [currentUserUid, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      //message number for id
      final snapshot =
          await chatRoomsRef.child('$chatRoomId/messagesNumber').get();
      if (snapshot.exists) {
        messagesNumber = jsonDecode(jsonEncode(snapshot.value)) as int;
      }

      await chatRoomsRef.child('$chatRoomId/messages').update({
        'id$messagesNumber': message.toJson(),
      });

      //update messages number
      messagesNumber++;
      await chatRoomsRef
          .child(chatRoomId)
          .update({'messagesNumber': messagesNumber});

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return false;
    }
  }

//get messages
  Future<List<MessageModel>> GetMessages(String receiverId) async {
    var messages = List<MessageModel>.empty(growable: true);

    try {
      var ids = [currentUserUid, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      final snapshot = await chatRoomsRef.child("$chatRoomId/messages").get();
      if (snapshot.exists) {
        final data =
            jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
        messages =
            data.values.map((item) => MessageModel.fromJson(item)).toList();
      }

      messages.sort((a, b) => a.time.compareTo(b.time));
      return messages;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      return messages;
    }
  }
}
