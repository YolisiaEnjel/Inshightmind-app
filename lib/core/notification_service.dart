// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   /// Inisialisasi notifikasi
//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   /// Tampilkan notifikasi langsung
//   static Future<void> showNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'screening_reminder',
//       'Screening Reminder',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }


// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter/material.dart';

// // class NotificationService {
// //   /// Notifikasi sederhana (aman, tidak butuh plugin)
// //   static void showNotification({
// //     required String title,
// //     required String body,
// //   }) {
// //     debugPrint('🔔 NOTIFICATION');
// //     debugPrint('Title : $title');
// //     debugPrint('Body  : $body');
// //   }
// // }

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   static Future<void> showNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'screening_channel',
//       'Screening Reminder',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class NotificationService {
//   static void showNotification({
//     required String title,
//     required String body,
//   }) {
//     debugPrint('🔔 $title');
//     debugPrint(body);
//   }
// }


import 'package:flutter/material.dart';

class NotificationService {
  /// Dipanggil dari main.dart
  static Future<void> init() async {
    debugPrint('🔔 NotificationService initialized');
  }

  /// Dipanggil dari ResultPage
  static void showNotification({
    required String title,
    required String body,
  }) {
    debugPrint('🔔 $title');
    debugPrint(body);
  }
}
