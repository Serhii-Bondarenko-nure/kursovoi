import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  const MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.time,
  });

  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final DateTime time;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  List<Object?> get props => [
        senderId,
        senderEmail,
        receiverId,
        message,
        time,
      ];
}
