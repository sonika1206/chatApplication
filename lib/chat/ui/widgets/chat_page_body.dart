import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/ui/widgets/app_bar.dart';
import 'package:chat2/chat/ui/widgets/message_bubble.dart';
import 'package:chat2/chat/ui/widgets/message_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatPageBody extends ConsumerStatefulWidget {
  final Chat chat;
  final String chatId;

  const ChatPageBody({Key? key, required this.chat, required this.chatId}) : super(key: key);

  @override
  ConsumerState<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends ConsumerState<ChatPageBody> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(widget.chatId));

    return Scaffold(
      appBar: userAsync.when(
        data: (user) {
          if (user == null) return const GradientAppBar(title: 'Chat');

          // Group Chat UI
          if (widget.chat.chatType == 'group') {
            return GradientAppBar(
              title: widget.chat.name ?? 'Group Chat',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/chats'),
              ),
            );
          }

          // 1-to-1 Chat: get other participant
          final otherParticipantId = widget.chat.participantIds
                  ?.firstWhere((id) => id != user.id, orElse: () => '') ??
              '';
          print("chat page:${otherParticipantId?? null}");
          if (otherParticipantId.isEmpty) {
            return const GradientAppBar(title: 'Invalid Chat');
          }

          final userDetailsAsync =
              ref.watch(usernameByIdProvider(otherParticipantId));

          return userDetailsAsync.when(
            data: (details) {
              final username = details?.username ?? 'Unknown User';
              return GradientAppBar(
                title: username,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/chats'),
                ),
              );
            },
            loading: () => const GradientAppBar(title: 'Loading...'),
            error: (e, _) => const GradientAppBar(title: 'Error'),
          );
        },
        loading: () => const GradientAppBar(title: 'Loading...'),
        error: (e, _) => const GradientAppBar(title: 'Error'),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Please log in'));

          return Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    _scrollToBottom();
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == user.id;
                        return MessageBubble(message: message, isMe: isMe);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
              MessageInputField(
                chatId: widget.chatId,
                senderId: user.id,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
