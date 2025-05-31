import 'dart:io';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoUpload extends ConsumerWidget {
  final String userId;

  const ProfilePhotoUpload({
    Key? key,
    required this.userId,
  }) : super(key: key);

  Future<void> _pickAndUploadPhoto(WidgetRef ref, BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No photo selected or permission denied')),
          );
        }
        return;
      }

      final file = File(pickedFile.path);
      final photoUrl = await ref.read(userServiceProvider).uploadProfilePhoto(userId, file);
      ref.invalidate(usernameByIdProvider(userId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile photo updated: $photoUrl')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading photo: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsAsync = ref.watch(usernameByIdProvider(userId));

    return userDetailsAsync.when(
      data: (details) {
        return GestureDetector(
          onTap: () => _pickAndUploadPhoto(ref, context),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: details?.profilePhotoUrl != null
                ? NetworkImage(details!.profilePhotoUrl!)
                : null,
            child: details?.profilePhotoUrl == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
        );
      },
      loading: () => const CircleAvatar(radius: 50, child: CircularProgressIndicator()),
      error: (e, _) => CircleAvatar(radius: 50, child: Text('Error: $e')),
    );
  }
}