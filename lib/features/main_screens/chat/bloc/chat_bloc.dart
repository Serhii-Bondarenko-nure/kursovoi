import 'dart:async';

import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.chatService}) : super(ChatInitial()) {
    on<LoadChatList>(_load);
    on<OpenChatByUserIdTapped>(
        (event, emit) => emit(NextChatWithUserPage(user: event.user)));
  }

  final ChatService chatService;

  FutureOr<void> _load(LoadChatList event, Emitter<ChatState> emit) async {
    try {
      if (state is! ChatListLoaded) {
        emit(ChatListLoading());
      }

      final users = await chatService.getUsersList();

      for (var i = 0; i < users.length; i++) {
        final storageRef = FirebaseStorage.instance.ref("user_logos");
        final imageUrl =
            await storageRef.child("${users[i].id}.png").getDownloadURL();
        users[i].photoUrl = imageUrl;
      }

      emit(ChatListLoaded(users: users));
    } catch (e, st) {
      emit(ChatErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
