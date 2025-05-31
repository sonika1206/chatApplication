import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserSelectionDialog extends ConsumerWidget {
  final String userId;

  const UserSelectionDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);

    return AlertDialog(
      title: const Text('Select User'),
      content: usersAsync.when(
        data: (users) {
          return users.isEmpty
              ? const Text('No users found')
              : SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      if (user['id'] == userId) return const SizedBox.shrink();
                      return ListTile(
                        title: Text(user['username'] ?? user['id']),
                        trailing: const Icon(Icons.chat),
                        onTap: () async {
                          try {
                            Navigator.pop(context);
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
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('Error: $e'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}