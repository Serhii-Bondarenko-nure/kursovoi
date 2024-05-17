import 'package:authorization/features/chat_room/bloc/chat_room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    required this.senderId,
    required this.message,
  });

  final String senderId;
  final String message;

  @override
  Widget build(BuildContext context) {
    final chatRoomBloc = BlocProvider.of<ChatRoomBloc>(context);

    bool isCurrentUser = senderId == chatRoomBloc.currentUserUid;

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: isCurrentUser
                    ? Colors.lightGreen
                    : const Color.fromARGB(255, 199, 197, 197),
                borderRadius: BorderRadius.circular(9)),
            padding: const EdgeInsets.all(10),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
