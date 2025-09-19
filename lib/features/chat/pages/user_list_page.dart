import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_user/features/chat/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final users = snapshot.data!.docs
              .where((doc) => doc.id != currentUser!.uid)
              .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        currentUserId: currentUser!.uid,
                        otherUserId: user.id,
                        otherUserName: user['name'],
                      ),
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
