import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Message {
  final String? id;

  @JsonKey(name: 'chat_id')
  final String? chatId;

  @JsonKey(name: 'sender_id')
  final String? senderId;

  final String? content;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? timestamp;

  @JsonKey(defaultValue: [])
  final List<String> readBy; // Added to track users who have read the message

  Message({
    this.id,
    this.chatId,
    this.senderId,
    this.content,
    this.timestamp,
    this.readBy = const [],
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    try {
      return _$MessageFromJson(json);
    } catch (e) {
      print('Error parsing message: $json, error: $e');
      return Message();
    }
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static DateTime? _fromJson(String? timestamp) =>
      timestamp != null ? DateTime.parse(timestamp) : null;
  static String? _toJson(DateTime? timestamp) =>
      timestamp?.toIso8601String();
}