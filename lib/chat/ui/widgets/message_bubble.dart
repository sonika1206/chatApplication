import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageBubble extends ConsumerWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({Key? key, required this.message, required this.isMe})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final usernameAsync = ref.watch(usernameByIdProvider(message.senderId!));
    final currentUserId = ref.watch(currentUserProvider).value?.id ?? '';
    final chat = ref
        .watch(userChatsProvider(currentUserId))
        .value
        ?.firstWhere(
          (chat) => chat.id == message.chatId,
          orElse: () => Chat(id: null, chatType: null),
        );

    final participantIds = chat?.participantIds ?? [];
    final otherParticipants = participantIds
        .where((id) => id != message.senderId)
        .toList();

    final allRead =
        otherParticipants.isNotEmpty &&
        otherParticipants.every((id) => message.readBy.contains(id));

    final bubbleColor = isMe
        ? theme.colorScheme.primary
        : Colors.grey.withOpacity(0.6);
    final textColor = isMe
        ? Colors.black
        : theme.colorScheme.onSecondary;
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              usernameAsync.when(
                data: (userDetails) => Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 4),
                  child: Text(
                    userDetails?.username ?? "Unknown",
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (e, _) => const Text("Error"),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content ?? '',
                    
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${message.timestamp?.hour ?? 0}:${message.timestamp?.minute.toString().padLeft(2, '0') ?? '00'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          //color: Colors.black,
                        ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
