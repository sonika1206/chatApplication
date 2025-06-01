import 'package:chat2/auth/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AppUser?> signUp(String email, String password, String username) async {
    try {
      final response = await supabase.auth.signUp(email: email, password: password);
      if (response.user == null) throw Exception('Signup failed: No user returned');

      await supabase.from('users').insert({
        'id': response.user!.id,
        'email': email,
        'username': username,
      });

      return AppUser(
        id: response.user!.id,
        email: email,
        username: username,
      );
    } catch (e) {
      print('Signup error: $e');
      rethrow;
    }
  }

  Future<AppUser?> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);
      if (response.user == null) throw Exception('Login failed: No user returned');

      final userData = await supabase.from('users').select().eq('id', response.user!.id).maybeSingle();
      if (userData == null) {
        // User exists in auth.users but not in users table
        try {
          await supabase.from('users').insert({
            'id': response.user!.id,
            'email': email,
          });
        } catch (insertError) {
          print('Insert user error: $insertError');
          throw Exception('Failed to create user record: $insertError');
        }
        return AppUser(
          id: response.user!.id,
          email: email,
          username: userData?["username"],
        );
      }

      return AppUser(
        id: response.user!.id,
        email: userData['email'] ?? email,
        username: userData['username'],
        profilePhotoUrl: userData['profile_photo_url'],
      );
    } catch (e) {
      print('SignIn error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      print('SignOut error: $e');
      rethrow;
    }
  }

  // AppUser? getCurrentUser() {
  //   final user = supabase.auth.currentUser;
  //   if (user == null) return null;
  //   return AppUser(id: user.id, email: user.email ?? '');
  // }

// AppUser? getCurrentUser() {
//   final user = supabase.auth.currentUser;
//   if (user == null) return null;
//   return AppUser(
//     id: user.id,
//     email: user.email ?? '',
//     // bio not fetched here — we fetch it in signIn, or consider using `fromJson` with Supabase row
//   );
// }

Future<AppUser?> getCurrentUser() async {
  final user = supabase.auth.currentUser;
  if (user == null) return null;

  final userData = await supabase
      .from('users')
      .select()
      .eq('id', user.id)
      .maybeSingle();

  if (userData == null) return null;

  return AppUser(
    id: user.id,
    email: userData['email'] ?? user.email ?? '',
    username: userData['username'],
    profilePhotoUrl: userData['profile_photo_url'],
  );
}

}