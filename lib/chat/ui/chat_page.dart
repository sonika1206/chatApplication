// import 'package:chat2/auth/logic/auth_provider.dart';
// import 'package:chat2/chat/logic/chat_provider.dart';
// import 'package:chat2/chat/model/chat_model.dart';
// import 'package:chat2/chat/ui/widgets/app_bar.dart';
// import 'package:chat2/chat/ui/widgets/message_bubble.dart';
// import 'package:chat2/chat/ui/widgets/message_input_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class ChatPage extends ConsumerStatefulWidget {

//   final String chatId;
//   const ChatPage({Key? key, required this.chatId}) : super(key: key);

//   @override
//   ConsumerState<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends ConsumerState<ChatPage> {
//   final _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userAsync = ref.watch(currentUserProvider);
//     final messagesAsync = ref.watch(messagesProvider(widget.chatId));

//     return Scaffold(
//       appBar: GradientAppBar(
//         title: "chat",
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.go('/chats'),
//         ),
//       ),
//       body: userAsync.when(
//         data: (user) => user == null
//             ? const Center(child: Text('Please log in'))
//             : Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: messagesAsync.when(
//                       data: (messages) {
//                         print('Rendering ${messages.length} messages');
//                         // Schedule scroll to bottom when messages update
//                         _scrollToBottom();
//                         return ListView.builder(
//                           controller: _scrollController,
//                           itemCount: messages.length,
//                           itemBuilder: (context, index) {
//                             final message = messages[index];
//                             final isMe = message.senderId == user.id;
//                             print('Message senderId=${message.senderId}, user.id=${user.id}, isMe=$isMe');
//                             return MessageBubble(message: message, isMe: isMe);
//                           },
//                         );
//                       },
//                       loading: () {
//                         print('Messages loading');
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                       error: (e, _) {
//                         print('Messages error: $e');
//                         return Center(child: Text('Error: $e'));
//                       },
//                     ),
//                   ),
//                   MessageInputField(
//                     chatId: widget.chatId,
//                     senderId: user.id,
//                   ),
//                 ],
//               ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text('Error: $e')),
//       ),
//     );
//   }
// }


import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/chat/logic/chat_provider.dart';
import 'package:chat2/chat/ui/widgets/chat_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// MAIN ENTRY WIDGET
class ChatPage extends ConsumerWidget {
  final String chatId;
  const ChatPage({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatByIdProvider(chatId));
    final userAsync = ref.watch(currentUserProvider);

    return chatAsync.when(
      data: (chat) {
        return ChatPageBody(chat: chat, chatId: chatId);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error loading chat: $e')),
      ),
    );
  }
}
