import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_user/features/chat/pages/chat_page.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // User not logged in
      return Scaffold(
        appBar: AppBar(title: const Text("Users")),
        body: const Center(child: Text("You must be logged in to see users")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs
              .where((doc) => doc.id != currentUser.uid)
              .toList();

          if (users.isEmpty) {
            return const Center(child: Text("No other users found"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(user['name'] ?? "Unknown"),
                subtitle: Text(user['email'] ?? ""),
                onTap: () {
                  navigateWithSlide(
                    context,
                    ChatPage(
                      currentUserId: currentUser.uid,
                      otherUserId: user.id,
                      otherUserName: user['name'] ?? "Unknown",
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
