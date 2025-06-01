import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageBubble extends ConsumerWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final usernameAsync = ref.watch(usernameByIdProvider(message.senderId!));
    final chat = ref.watch(userChatsProvider(ref.watch(currentUserProvider).value?.id ?? '')).value
        ?.firstWhere((chat) => chat.id == message.chatId, orElse: () => Chat(id: null, chatType: null));
    final participantIds = chat?.participantIds ?? [];

    final otherParticipants = participantIds.where((id) => id != message.senderId).toList();
    final allRead = otherParticipants.isNotEmpty &&
        otherParticipants.every((id) => message.readBy.contains(id));

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                usernameAsync.when(
              data: (userDetails) => Text(
                userDetails?.username ?? "Unknown User",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: isMe ? Colors.white70 : Colors.black54,
                ),
              ),
              loading: () => const Text(
                'Loading...',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
              error: (e, _) => Text(
                'Error: $e',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ),
                Text(
                  message.content ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                if (message.timestamp != null)
                  Text(
                    '${message.timestamp!.hour}:${message.timestamp!.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            if (isMe) ...[
              const SizedBox(width: 5),
              Icon(
                allRead ? Icons.done_all : Icons.done,
                size: 16,
                color: allRead ? Colors.blue : Colors.grey,
              ),
            ],
          ],
        ),
      ),
    );
  }
}