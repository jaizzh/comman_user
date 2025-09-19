import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class SimpleAwesomeNotification {
  static bool _inited = false;

  /// Call this once at app start (BEFORE runApp preferred)
  static Future<void> init() async {
    if (_inited) return;
    _inited = true;

    AwesomeNotifications().initialize(
      null, // app icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'General',
          channelDescription: 'General notifications',
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          playSound: true,
          enableVibration: true,
          ledColor: Colors.white,
        ),
      ],
      debug: false,
    );

    // Android 13+ or iOS: ask runtime permission
    final allowed = await AwesomeNotifications().isNotificationAllowed();
    if (!allowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Fire-and-forget simple notification
  static Future<void> show(String title, String body,
      {Map<String, String>? payload}) async {
    // Safety: ensure initialized even if caller forgot
    if (!_inited) {
      await init();
    }

    final id = DateTime.now().millisecondsSinceEpoch % 100000;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: payload,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
