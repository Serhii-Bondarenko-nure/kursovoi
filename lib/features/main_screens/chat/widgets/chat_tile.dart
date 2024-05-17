import 'package:authorization/core/constants/path_constants.dart';
import 'package:authorization/core/services/chat/user_chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.user,
    required this.onTap,
  });

  final UserChatModel user;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (user.id != FirebaseAuth.instance.currentUser!.uid) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 233, 233),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 10,
          right: 10,
        ),
        child: ListTile(
          leading: user.photoUrl == null
              ? const CircleAvatar(
                  backgroundImage: AssetImage(PathConstants.profile),
                  radius: 30)
              : CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                      child: FadeInImage.assetNetwork(
                    placeholder: PathConstants.profile,
                    image: user.photoUrl,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 120,
                  )),
                ),
          title: Text(
            user.displayName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          onTap: onTap,
        ),
      );
    } else {
      return Container();
    }
  }
}
