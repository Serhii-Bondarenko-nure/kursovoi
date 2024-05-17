part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {}

class ChatRoomInitial extends ChatRoomState {
  @override
  List<Object?> get props => [];
}

class ChatRoomLoading extends ChatRoomState {
  @override
  List<Object?> get props => [];
}

class ChatRoomLoaded extends ChatRoomState {
  ChatRoomLoaded({required this.messages});

  final List<MessageModel> messages;

  @override
  List<Object?> get props => [messages];
}

class NextReloadedState extends ChatRoomState {
  @override
  List<Object?> get props => [];
}

class ChatRoomErrorState extends ChatRoomState {
  ChatRoomErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
