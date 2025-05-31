import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import '../model/user_details.dart';

class UserService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final users = await supabase.from('users').select('id, username');
      print('Fetched ${users.length} users');
      return users;
    } catch (e) {
      print('Get users error: $e');
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> streamAllUsers() {
    return supabase
        .from('users')
        .stream(primaryKey: ['id'])
        .order('username', ascending: true)
        .map((data) {
          print('Stream update: ${data.length} users');
          return data.map((json) => json as Map<String, dynamic>).toList();
        });
  }

  Future<UserDetails?> getUsername(String userId) async {
    try {
      final user = await supabase
          .from('users')
          .select('username, profile_photo_url')
          .eq('id', userId)
          .single();
      return UserDetails.fromJson(user);
    } catch (e) {
      print('Get username error for userId=$userId: $e');
      return null;
    }
  }

  Future<String?> uploadProfilePhoto(String userId, File photo) async {
    try {
      final fileName = '$userId-profile.jpg';
      final response = await supabase.storage
          .from('profile-photos')
          .upload(
            fileName,
            photo,
            fileOptions: const FileOptions(upsert: true),
          );
      print('Photo uploaded: $response');
      final photoUrl = supabase.storage
          .from('profile-photos')
          .getPublicUrl(fileName);
      await supabase
          .from('users')
          .update({'profile_photo_url': photoUrl})
          .eq('id', userId);
      print('Profile photo URL updated: $photoUrl');
      return photoUrl;
    } catch (e) {
      print('Upload profile photo error: $e');
      throw Exception('Failed to upload profile photo: $e');
    }
  }
}
