import 'package:authorization/core/constants/text_constants.dart';
import 'package:authorization/core/services/chat/chat_service.dart';
import 'package:authorization/features/main_screens/chat/bloc/chat_bloc.dart';
import 'package:authorization/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final chatBloc = ChatBloc(chatService: GetIt.I<ChatService>())
    ..add(LoadChatList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.chatIcon)),
        automaticallyImplyLeading: false,
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return BlocProvider<ChatBloc>(
      create: (context) => chatBloc,
      child: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is NextChatWithUserPage) {
            AutoRouter.of(context)
                .push(ChatRoomRoute(user: state.user))
                .then((result) => chatBloc.add(LoadChatList()));
          } else if (state is ChatErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.exeption.toString())));
          }
        },
        child: ChatContent(),
      ),
    );
  }
}
