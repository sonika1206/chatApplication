import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/model/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  Future<void> sendMessage(String chatId, String senderId, String content) async {
    try {
      await supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'content': content,
      });
      print('Sent message: chatId=$chatId, senderId=$senderId');
    } catch (e) {
      print('Send message error: $e');
      rethrow;
    }
  }

  Future<String> createGroupChat(String groupName, List<String> participantIds, String currentUserId) async {
    try {
      print('Creating group chat with name: $groupName'); // Debug log
      final chatResponse = await supabase.from('chats').insert({
        'chat_type': 'group',
        'name': groupName,
      }).select('id').single();
      final chatId = chatResponse['id'] as String;

      final participants = [
        {'chat_id': chatId, 'user_id': currentUserId},
        ...participantIds.map((userId) => {'chat_id': chatId, 'user_id': userId}),
      ];
      await supabase.from('chat_participants').insert(participants);

      return chatId;
    } catch (e) {
      print('Create group chat error: $e');
      throw Exception('Failed to create group chat: $e');
    }
  }

  Stream<List<Message>> getMessages(String chatId) {
    final stream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .map((data) {
          print('Messages stream update: ${data.length} messages for chatId=$chatId');
          final validMessages = data
              .map((json) => Message.fromJson(json))
              .where((msg) => msg.id != null && msg.content != null)
              .toList();
          print('Valid messages: ${validMessages.length} for chatId=$chatId');
          return validMessages;
        });
    return stream;
  }

  Future<String> createChat(String recipientId, String senderId) async {
    try {
      final senderChats = await supabase
          .from('chat_participants')
          .select('chat_id')
          .eq('user_id', senderId);

      final recipientChats = await supabase
          .from('chat_participants')
          .select('chat_id')
          .eq('user_id', recipientId);

      final senderChatIds = senderChats.map((p) => p['chat_id'] as String).toSet();
      final recipientChatIds = recipientChats.map((p) => p['chat_id'] as String).toSet();

      final commonChatIds = senderChatIds.intersection(recipientChatIds).toList();

      if (commonChatIds.isNotEmpty) {
        final chatData = await supabase
            .from('chats')
            .select('id')
            .inFilter('id', commonChatIds)
            .eq('chat_type', 'one_to_one')
            .maybeSingle();

        if (chatData != null) {
          print('Existing chat found: ${chatData['id']}');
          return chatData['id'] as String;
        }
      }
      print('No existing 1:1 chat, creating new one');
    } catch (e) {
      print('Error checking existing chat: $e');
    }

    try {
      final chatResponse = await supabase.from('chats').insert({
        'chat_type': 'one_to_one',
      }).select('id').single();
      final chatId = chatResponse['id'] as String;
      print('Created chat with ID: $chatId');

      await supabase.from('chat_participants').insert([
        {'chat_id': chatId, 'user_id': senderId},
        {'chat_id': chatId, 'user_id': recipientId},
      ]);
      return chatId;
    } catch (e) {
      print('Create chat error: $e');
      throw Exception('Failed to create chat: $e');
    }
  }

  Stream<List<Chat>> getUserChats(String userId) {
    return supabase
        .from('chat_participants')
        .stream(primaryKey: ['chat_id', 'user_id'])
        .eq('user_id', userId)
        .asyncMap((participants) async {
          print('Stream update: ${participants.length} participants for userId=$userId');
          final chatIds = participants.map((p) => p['chat_id'] as String).toList();
          if (chatIds.isEmpty) return <Chat>[];

          final chatsData = await supabase
              .from('chats')
              .select('id, chat_type, name') 
              .inFilter('id', chatIds);

          print('Fetched chats data: $chatsData');

          final chats = <Chat>[];
          for (final chat in chatsData) {
            final participantData = await supabase
                .from('chat_participants')
                .select('user_id')
                .eq('chat_id', chat['id']);

            final participantIds = participantData.map((p) => p['user_id'] as String).toList();

            final lastMessageData = await supabase
                .from('messages')
                .select('id, content, created_at')
                .eq('chat_id', chat['id'])
                .order('created_at', ascending: false)
                .limit(1)
                .maybeSingle();

            chats.add(Chat(
              id: chat['id'],
              chatType: chat['chat_type'],
              name: chat['name'], 
              participantIds: participantIds,
              lastMessage: lastMessageData != null ? Message.fromJson(lastMessageData) : null,
            ));
          }
          return chats;
        });
  }
}