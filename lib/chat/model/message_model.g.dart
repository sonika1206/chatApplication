// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String?,
  chatId: json['chat_id'] as String?,
  senderId: json['sender_id'] as String?,
  content: json['content'] as String?,
  timestamp: Message._fromJson(json['timestamp'] as String?),
  readBy:
      (json['readBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'chat_id': instance.chatId,
  'sender_id': instance.senderId,
  'content': instance.content,
  'timestamp': Message._toJson(instance.timestamp),
  'readBy': instance.readBy,
};
