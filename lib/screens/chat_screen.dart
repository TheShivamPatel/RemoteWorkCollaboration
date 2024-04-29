import 'package:chatterbox/widgets/chat_messages.dart';
import 'package:chatterbox/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Team Chat'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessages(chatId: chatId,)),
            NewMessage(chatId: chatId,),
          ],
        ));
  }
}
