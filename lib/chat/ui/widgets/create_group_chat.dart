import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateGroupChatDialog extends ConsumerStatefulWidget {
  final String currentUserId;
  final List<Map<String, dynamic>> users;

  const CreateGroupChatDialog({
    Key? key,
    required this.currentUserId,
    required this.users,
  }) : super(key: key);

  @override
  ConsumerState<CreateGroupChatDialog> createState() => _CreateGroupChatDialogState();
}

class _CreateGroupChatDialogState extends ConsumerState<CreateGroupChatDialog> {
  final TextEditingController groupNameController = TextEditingController();
  final List<String> selectedUserIds = [];

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Create Group Chat',
        style: TextStyle(color: Colors.blue),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: groupNameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                hintText: 'Enter group name',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Select Participants:'),
            ...widget.users.map((user) {
              if (user['id'] == widget.currentUserId) return const SizedBox.shrink();
              return CheckboxListTile(
                title: Text(user['username']?.toString() ?? user['id'].toString()),
                value: selectedUserIds.contains(user['id']),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedUserIds.add(user['id']);
                    } else {
                      selectedUserIds.remove(user['id']);
                    }
                  });
                },
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (groupNameController.text.trim().isEmpty || selectedUserIds.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a group name and select at least one participant')),
              );
              return;
            }
            Navigator.pop(context);
            try {
              final chatId = await ref.read(createGroupChatProvider(
                groupNameController.text.trim(),
                selectedUserIds,
                widget.currentUserId,
              ).future);
              ref.invalidate(userChatsProvider(widget.currentUserId));
              if (context.mounted) {
                context.go('/chat/$chatId');
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error creating group chat: $e'), backgroundColor: Colors.redAccent),
                );
              }
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}