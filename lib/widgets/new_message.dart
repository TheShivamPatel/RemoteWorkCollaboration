import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.chatId});

  final String chatId;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection('chats').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['name'],
      'userImage': userData.data()!['image'],
      // 'chatId': userData.data()!['chatId'],
      'chatId' : widget.chatId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 2),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(hintText: 'Message'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
