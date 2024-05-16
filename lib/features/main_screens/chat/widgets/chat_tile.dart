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
      return ListTile(
        leading: //Icon(Icons.abc),
            user.photoUrl == null
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
        //trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      );
    } else {
      return Container();
    }
  }
}
