import 'package:authorization/core/consts/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.chatIcon)),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
