// lib/chat/service/chat_query_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/chat_model.dart';
import '../model/message_model.dart';

class ChatQueryService {
  final supabase = Supabase.instance.client;

  Future<Chat> fetchChatById(String chatId) async {
    // Fetch base chat info
    final chatRes = await supabase
        .from('chats')
        .select('id, chat_type, name')
        .eq('id', chatId)
        .single();

    // Fetch participant IDs
    final participantsRes = await supabase
        .from('chat_participants')
        .select('user_id')
        .eq('chat_id', chatId);

    final participantIds = participantsRes
        .map<String>((p) => p['user_id'] as String)
        .toList();

    // Fetch latest message (optional)
    final lastMessageRes = await supabase
        .from('messages')
        .select('id, content, sender_id, created_at')
        .eq('chat_id', chatId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    return Chat(
      id: chatRes['id'] as String,
      chatType: chatRes['chat_type'] as String,
      name: chatRes['name'] as String?,
      participantIds: participantIds,
      lastMessage:
          lastMessageRes != null ? Message.fromJson(lastMessageRes) : null,
    );
  }
}
