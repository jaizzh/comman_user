import 'package:flutter/material.dart';

class NotificationHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 8,
        margin: const EdgeInsets.fromLTRB(
            16, 16, 16, 0), // top margin to show near top
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.deepPurple.shade200, width: 1.5),
        ),
      ),
    );
  }
}
