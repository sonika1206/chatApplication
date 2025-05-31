import 'package:chat2/auth/model/auth_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthServiceProvider extends _$AuthServiceProvider {
  @override
  AuthService build() => AuthService();
}

@riverpod
Future<AppUser?> currentUser(CurrentUserRef ref) async {
  final authService = ref.watch(authServiceProviderProvider);
  return authService.getCurrentUser();
}