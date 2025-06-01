// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
  id: json['id'] as String?,
  chatType: json['chat_type'] as String?,
  name: json['name'] as String?,
  participantIds: (json['participantIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  lastMessage: json['lastMessage'] == null
      ? null
      : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
  'id': instance.id,
  'chat_type': instance.chatType,
  'name': instance.name,
  'participantIds': instance.participantIds,
  'lastMessage': instance.lastMessage,
};
