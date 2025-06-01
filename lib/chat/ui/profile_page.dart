import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/theme_provider.dart';
import 'package:chat2/chat/ui/widgets/app_bar.dart';
import 'package:chat2/chat/ui/widgets/progile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isEditing = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await ref.read(authServiceProviderProvider).signOut();
                ref.invalidate(currentUserProvider);
                if (context.mounted) context.go('/login');
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error signing out: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Please log in'));
          }

          _usernameController.text = user.username ?? '';
          _bioController.text = user.bio ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Photo
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ProfilePhotoUpload(userId: user.id),
                ),
                 const SizedBox(height: 16),
                 Text(
      user.username!.toUpperCase() ?? 'No username',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
    ),

                const SizedBox(height: 20),

                // Username Field
                TextField(
                  controller: _usernameController,
                  enabled: _isEditing,
                  decoration: const InputDecoration(
                    hoverColor: Colors.black,
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Bio Field
                TextField(
                  controller: _bioController,
                  enabled: _isEditing,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Save / Edit button
                ElevatedButton.icon(
                  onPressed: _isSaving
                      ? null
                      : () async {
                          if (_isEditing) {
                            setState(() => _isSaving = true);
                            try {
                              await Supabase.instance.client
                                  .from('users')
                                  .update({
                                    'username': _usernameController.text.trim(),
                                    'bio': _bioController.text.trim(),
                                  })
                                  .eq('id', user.id);
                              ref.invalidate(currentUserProvider);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profile updated')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                            setState(() {
                              _isSaving = false;
                              _isEditing = false;
                            });
                          } else {
                            setState(() => _isEditing = true);
                          }
                        },
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  label: Text(_isEditing ? 'Save' : 'Edit Profile'),
                ),

                const SizedBox(height: 24),

                // Dark Mode Toggle
                SwitchListTile(
                  value: ref.watch(themeNotifierProvider) == ThemeMode.dark,
                  onChanged: (_) {
                    ref.read(themeNotifierProvider.notifier).toggle();
                  },
                  title: const Text("Dark Mode"),
                  secondary: const Icon(Icons.dark_mode),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
