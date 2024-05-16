part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatListLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatListLoaded extends ChatState {
  ChatListLoaded({required this.users});

  final List<UserChatModel> users;

  @override
  List<Object?> get props => [users];
}

class NextChatWithUserPage extends ChatState {
  NextChatWithUserPage({
    required this.user,
  });

  UserChatModel user;

  @override
  List<Object?> get props => [user];
}

class ChatErrorState extends ChatState {
  ChatErrorState({required this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}
