import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListTile extends ConsumerWidget {
  final Chat chat;
  final String userId;

  const ChatListTile({
    Key? key,
    required this.chat,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (chat.chatType == 'group') {
      print('Group chat name: ${chat.name}');
      return ListTile(
        leading: CircleAvatar(
          child: chat.name != null ? Text(chat.name![0]) : const Icon(Icons.group),
        ),
        title: Text(chat.name ?? 'Group Chat'),
        subtitle: Text(chat.lastMessage?.content ?? 'No messages'),
        onTap: () => context.go('/chat/${chat.id}', extra: chat),
      );
    }

    final otherParticipantId = chat.participantIds?.firstWhere(
          (id) => id != userId,
          orElse: () => '',
        ) ?? '';

    final userDetailsAsync = ref.watch(usernameByIdProvider(otherParticipantId));
    return userDetailsAsync.when(
      data: (details) {
        final username = details?.username ?? 'User $otherParticipantId';
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: details?.profilePhotoUrl != null
                ? NetworkImage(details!.profilePhotoUrl!)
                : null,
            child: details?.profilePhotoUrl == null
                ? const Icon(Icons.person)
                : null,
          ),
          title: Text(username),
          subtitle: Text(chat.lastMessage?.content ?? 'No messages'),
          onTap: () => context.go('/chat/${chat.id}'),
        );
      },
      loading: () => const ListTile(title: Text('Loading...')),
      error: (e, _) => ListTile(title: Text('Error: $e')),
    );
  }
}