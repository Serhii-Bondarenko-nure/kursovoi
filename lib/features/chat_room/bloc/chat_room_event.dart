part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {}

class LoadChatRoom extends ChatRoomEvent {
  LoadChatRoom({required this.receiverId});

  String receiverId;

  @override
  List<Object?> get props => [receiverId];
}

class SendMessageTapped extends ChatRoomEvent {
  SendMessageTapped({
    required this.receiverId,
    required this.messageText,
  });

  String receiverId;
  String messageText;

  @override
  List<Object?> get props => [
        receiverId,
        messageText,
      ];
}
