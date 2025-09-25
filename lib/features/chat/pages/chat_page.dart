// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;

  const ChatPage(
      {super.key,
      required this.currentUserId,
      required this.otherUserId,
      required this.otherUserName});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  String getChatId() {
    // Always same chatId for both users
    if (widget.currentUserId.compareTo(widget.otherUserId) > 0) {
      return "${widget.otherUserId}_${widget.currentUserId}";
    } else {
      return "${widget.currentUserId}_${widget.otherUserId}";
    }
  }

  void sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final chatId = getChatId();

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': widget.currentUserId,
      'receiverId': widget.otherUserId,
      'text': _controller.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatId = getChatId();

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: Text(
          widget.otherUserName,
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        actions: const [
          Icon(Icons.message),
          SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: AppColors.paper,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/png/logo.png"),
          scale: 5,
        )),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var msg = messages[index];
                      bool isMe = msg['senderId'] == widget.currentUserId;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AppColors.lightGold.withOpacity(0.7)
                                : Colors.pink.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: isMe
                                  ? const Radius.circular(12)
                                  : const Radius.circular(0),
                              bottomRight: isMe
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            msg['text'],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.gray.withOpacity(0.2)),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                              hintText: "Type a message...",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: sendMessage,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
