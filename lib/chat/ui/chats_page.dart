import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/ui/widgets/app_bar.dart';
import 'package:chat2/chat/ui/widgets/chat_list_tile.dart';
import 'package:chat2/chat/ui/widgets/error.dart';
import 'package:chat2/chat/ui/widgets/user_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Chats',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await ref.read(authServiceProviderProvider).signOut();
                ref.invalidate(currentUserProvider);
                await Future.delayed(Duration.zero);
                if (context.mounted) context.go('/login');
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:ErrorMsg(message: "Error signing out!!"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) => user == null
            ? const Center(child: Text('Please log in'))
            : _buildChatList(context, ref, user.id),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorMsg(message: "Got an unexpected error"),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, WidgetRef ref, String userId) {
    final chatsAsync = ref.watch(userChatsProvider(userId));

    return chatsAsync.when(
      data: (chats) => chats.isEmpty
          ? const ErrorMsg(message: "Add An User To Start Conversation With !!!")
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatListTile(chat: chat, userId: userId);
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorMsg(message: "Error loading Chats!!"),
    );
  }

  void _showUserSelectionDialog(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider).value?.id ?? '';
    showDialog(
      context: context,
      builder: (context) => UserSelectionDialog(userId: userId),
    );
  }
}
