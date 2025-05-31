
import 'package:chat2/chat/model/chat_model.dart';
import 'package:chat2/chat/model/message_model.dart';
import 'package:chat2/chat/model/user_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'chat_service.dart';
import 'user_service.dart';

part 'chat_provider.g.dart';

// Chat service provider
@riverpod
ChatService chatService(ChatServiceRef ref) => ChatService();

// User service provider
@riverpod
UserService userService(UserServiceRef ref) => UserService();

// Stream of chats for a user
@riverpod
Stream<List<Chat>> userChats(UserChatsRef ref, String userId) {
  return ref.watch(chatServiceProvider).getUserChats(userId);
}

// Stream of messages for a specific chat
@riverpod
Stream<List<Message>> messages(MessagesRef ref, String chatId) {
  return ref.watch(chatServiceProvider).getMessages(chatId);
}

// Stream of all users
@riverpod
Stream<List<Map<String, dynamic>>> allUsers(AllUsersRef ref) {
  return ref.watch(userServiceProvider).streamAllUsers();
}

// Future provider to get username by userId (used in UI)
@riverpod
Future<UserDetails?> usernameById(UsernameByIdRef ref, String userId) async {
  return ref.watch(userServiceProvider).getUsername(userId);
}

// Create a group chat
@riverpod
Future<String> createGroupChat(CreateGroupChatRef ref, String groupName, List<String> participantIds, String currentUserId) async {
  return ref.watch(chatServiceProvider).createGroupChat(groupName, participantIds, currentUserId);
}


