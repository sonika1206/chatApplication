import 'package:json_annotation/json_annotation.dart';
import 'message_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat {
  final String? id;
  final String? chatType;
  @JsonKey(name: 'name')
  final String? name;
  final List<String>? participantIds;
  final Message? lastMessage;

  Chat({
    this.id,
    this.chatType,
    this.name,
    this.participantIds,
    this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}