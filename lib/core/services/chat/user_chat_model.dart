import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_chat_model.g.dart';

@JsonSerializable()
class UserChatModel extends Equatable {
  UserChatModel({
    required this.id,
    required this.email,
    required this.displayName,
  });

  String id;
  String email;
  String displayName;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  late String photoUrl;

  factory UserChatModel.fromJson(Map<String, dynamic> json) =>
      _$UserChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserChatModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
      ];
}
