import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatWithUserScreen extends StatelessWidget {
  const ChatWithUserScreen({
    super.key,
    required this.user,
  });

  final UserChatModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
