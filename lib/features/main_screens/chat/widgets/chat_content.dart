import 'package:authorization/features/main_screens/chat/bloc/chat_bloc.dart';
import 'package:authorization/features/main_screens/chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return BlocBuilder<ChatBloc, ChatState>(
      bloc: chatBloc,
      builder: (context, state) {
        if (state is ChatListLoaded) {
          if (state.users.isEmpty) {
            return const Center(
                child: Text(
              "You don't have chats...",
              style: TextStyle(fontSize: 20),
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              itemCount: state.users.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return ChatTile(
                  user: state.users[index],
                  onTap: () {
                    chatBloc
                        .add(OpenChatByUserIdTapped(user: state.users[index]));
                  },
                );
              },
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
