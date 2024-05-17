part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {}

class LoadChatList extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class OpenChatByUserIdTapped extends ChatEvent {
  OpenChatByUserIdTapped({
    required this.user,
  });

  UserChatModel user;

  @override
  List<Object?> get props => [user];
}
