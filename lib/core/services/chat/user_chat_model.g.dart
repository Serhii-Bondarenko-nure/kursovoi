// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChatModel _$UserChatModelFromJson(Map<String, dynamic> json) =>
    UserChatModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$UserChatModelToJson(UserChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
    };
