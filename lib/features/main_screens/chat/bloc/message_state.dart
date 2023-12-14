part of 'message_bloc.dart';

abstract class MessageState extends Equatable {}

class MessageInitial extends MessageState {
  @override
  List<Object?> get props => [];
}
