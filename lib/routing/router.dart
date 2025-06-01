import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/auth/ui/login_page.dart';
import 'package:chat2/auth/ui/signup_page.dart';
import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/ui/chat_page.dart';
import 'package:chat2/chat/ui/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final user = await ref.read(currentUserProvider.future);
      final path = state.fullPath ?? '/';

      if (user == null && path != '/login' && path != '/signup') {
        return '/login';
      }
      if (user != null && path != '/chat' && !path.startsWith('/chat/')) {
        return '/chat';
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: '/chat',
            builder: (context, state) => const NavigationPage(),
          ),
          GoRoute(
            path: '/chat/:chatId',
            builder: (context, state) => ChatPage(chatId: state.pathParameters['chatId']!),
          ),
        ],
      ),
    ],
  );
});