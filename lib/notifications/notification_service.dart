import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  ///  Notifier to update notifications screen when the notification arrived while its open
  static final ValueNotifier<List<Map<String, dynamic>>> notificationsNotifier =
      ValueNotifier([]);

  // initiate notifications
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    // print token
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    // initialize local notification
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );
    await _localNotifications.initialize(initSettings);

    // topic for all users
    await _firebaseMessaging.subscribeToTopic("all_users");

    // receive notification when app is open
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint("onMessage");
      final notif = _buildNotification(message);
      await _saveNotification(notif);
      await _showForegroundNotification(notif);
    });

    // receive notification when app is on background
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      debugPrint("onMessageOpenedApp");
      final notif = _buildNotification(message);
      await _saveNotification(notif);
    });

    // receive notification when app is closed
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint("getInitialMessage");
      final notif = _buildNotification(initialMessage);
      await _saveNotification(notif);
    }
    notificationsNotifier.value = await getNotifications();
  }

  // build notification
  Map<String, dynamic> _buildNotification(RemoteMessage message) {
    final title = message.notification?.title ?? "No title";
    final body = message.notification?.body ?? "No body";
    final now = TimeOfDay.now().format(navigatorKey.currentContext!);

    final iconPath;
    if (title.contains("Order")) {
      iconPath = "assets/images/notification_icons/order.png";
    } else if (title.contains("Check")) {
      iconPath = "assets/images/notification_icons/promo.png";
    } else if (title.contains("Promo")) {
      iconPath = "assets/images/notification_icons/promo.png";
    } else if (title.contains("New")) {
      iconPath = "assets/images/notification_icons/new.png";
    } else if (title.contains("Done")) {
      iconPath = "assets/images/notification_icons/check.png";
    } else {
      iconPath = "assets/images/appLogo.png";
    }
    return {"title": title, "subtitle": body, "time": now, "image": iconPath};
  }

  // show the notification in foreground using localPlugin
  Future<void> _showForegroundNotification(Map<String, dynamic> notif) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'flory_channel', // channel identifier
          'Flory Notifications',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      notif['title'],
      notif['subtitle'],
      platformDetails,
    );
  }

  // function to save Notifications in sharedPreferences
  Future<void> _saveNotification(Map<String, dynamic> notif) async {
    final prefs = await SharedPreferences.getInstance();
    final currentNotifs = await getNotifications();

    // add the notification at first always
    currentNotifs.insert(0, notif);

    // store in SharedPreferences
    await prefs.setStringList(
      'notifications',
      currentNotifs.map((n) => n.toString()).toList(),
    );

    // update the ValueNotifier
    notificationsNotifier.value = List.from(currentNotifs);
  }

  //function to get notifications from SharedPreferences
  Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('notifications') ?? [];
    return stored.map((s) {
      final parts = s.replaceAll('{', '').replaceAll('}', '').split(', ');
      final map = <String, dynamic>{};
      for (var part in parts) {
        final kv = part.split(': ');
        if (kv.length == 2) map[kv[0]] = kv[1];
      }
      return map;
    }).toList();
  }

  // function to clear all the notifications
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    notificationsNotifier.value = [];
  }
}
