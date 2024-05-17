import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:authorization/features/chat_room/bloc/chat_room_bloc.dart';
import 'package:authorization/features/chat_room/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ChatRoomScreen extends StatelessWidget {
  ChatRoomScreen({
    super.key,
    required this.user,
  });

  final UserChatModel user;

  late final chatRoomBloc = ChatRoomBloc(chatService: GetIt.I<ChatService>())
    ..add(LoadChatRoom(receiverId: user.id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
        centerTitle: true,
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return BlocProvider<ChatRoomBloc>(
      create: (context) => chatRoomBloc,
      child: BlocListener<ChatRoomBloc, ChatRoomState>(
        listener: (context, state) {
          if (state is NextReloadedState) {
            chatRoomBloc.add(LoadChatRoom(receiverId: user.id));
          } else if (state is ChatRoomErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        child: ChatRoomContent(
          id: user.id,
        ),
      ),
    );
  }
}
