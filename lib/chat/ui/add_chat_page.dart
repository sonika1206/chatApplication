import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/ui/widgets/app_bar.dart';
import 'package:chat2/chat/ui/widgets/create_group_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddChatPage extends ConsumerWidget {
  const AddChatPage({super.key});

  Future<void> _createGroupChat(BuildContext context, WidgetRef ref, String currentUserId) async {
    final users = await ref.read(allUsersProvider.future);
    await showDialog(
      context: context,
      builder: (context) => CreateGroupChatDialog(
        currentUserId: currentUserId,
        users: users,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);
    final userId = ref.watch(currentUserProvider).value?.id ?? '';

    return Scaffold(
      appBar: const GradientAppBar(title: 'Add Chat'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => _createGroupChat(context, ref, userId),
              icon: const Icon(Icons.group_add),
              label: const Text('Create Group Chat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) {
                return users.isEmpty
                    ? const Center(child: Text('No users found'))
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          if (user['id'] == userId) return const SizedBox.shrink();
                          return ListTile(
                            title: Text(user['username']?.toString() ?? user['id'].toString()),
                            trailing: const Icon(Icons.chat),
                            onTap: () async {
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Starting chat...')),
                                );
                                final chatId = await ref.read(chatServiceProvider).createChat(
                                      user['id'],
                                      userId,
                                    );
                                ref.invalidate(userChatsProvider(userId));
                                await Future.delayed(Duration.zero);
                                if (context.mounted) {
                                  context.go('/chat/$chatId');
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error starting chat: $e'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}