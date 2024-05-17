import 'dart:async';

import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:authorization/core/services/chat/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'chat_room_state.dart';
part 'chat_room_event.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc({required this.chatService}) : super(ChatRoomInitial()) {
    on<LoadChatRoom>(_load);
    on<SendMessageTapped>((event, emit) async {
      await chatService.SendMessage(event.receiverId, event.messageText);
      messageController.text = '';

      emit(NextReloadedState());
    });
  }

  final ChatService chatService;
  final TextEditingController messageController = TextEditingController();
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  FutureOr<void> _load(LoadChatRoom event, Emitter<ChatRoomState> emit) async {
    try {
      if (state is! ChatRoomLoaded) {
        emit(ChatRoomLoading());
      }

      final messages = await chatService.GetMessages(event.receiverId);

      emit(ChatRoomLoaded(messages: messages));
    } catch (e, st) {
      emit(ChatRoomErrorState(exeption: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
