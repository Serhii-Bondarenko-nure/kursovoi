import 'package:authorization/features/chat_room/bloc/chat_room_bloc.dart';
import 'package:authorization/features/chat_room/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomContent extends StatelessWidget {
  ChatRoomContent({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildMessageList(context)),
        _buildUserInput(context),
      ],
    );
  }

  Widget _buildMessageList(BuildContext context) {
    final chatRoomBloc = BlocProvider.of<ChatRoomBloc>(context);
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      bloc: chatRoomBloc,
      builder: (context, state) {
        if (state is ChatRoomLoaded) {
          if (state.messages.isEmpty) {
            return const Center(
                child: Text(
              "Your messages will be here...",
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
              itemCount: state.messages.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return ChatBubble(
                  senderId: state.messages[index].senderId,
                  message: state.messages[index].message,
                );
              },
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildUserInput(BuildContext context) {
    final chatRoomBloc = BlocProvider.of<ChatRoomBloc>(context);
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      bloc: chatRoomBloc,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 10,
                left: 20,
                right: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatRoomBloc.messageController,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () => chatRoomBloc.add(SendMessageTapped(
                      receiverId: id,
                      messageText: chatRoomBloc.messageController.text,
                    )),
                    icon: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
