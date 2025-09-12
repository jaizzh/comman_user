import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  /// Save user data from Firestore into SharedPreferences
  static Future<void> saveUserDataToLocal(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (userDoc.exists) {
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        await prefs.setString("userId", uid);
        await prefs.setString("name", data["name"] ?? "");
        await prefs.setString("email", data["email"] ?? "");
        await prefs.setString("mobile", data["mobile"] ?? "");
        await prefs.setString("profileImageUrl", data["profileImageUrl"] ?? "");
      }
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  /// Get saved user data
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "userId": prefs.getString("userId") ?? "",
      "name": prefs.getString("name") ?? "",
      "email": prefs.getString("email") ?? "",
      "mobile": prefs.getString("mobile") ?? "",
      "profileImageUrl": prefs.getString("profileImageUrl") ?? "",
    };
  }

  /// Clear saved user data (logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");
    await prefs.remove("name");
    await prefs.remove("email");
    await prefs.remove("mobile");
    await prefs.remove("profileImageUrl");
  }
}
