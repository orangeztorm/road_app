// import 'dart:io';

// import 'package:beam/cores/__cores.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:overlay_support/overlay_support.dart' hide Toast;

// class NotificationManager {
//   static bool _initialized = false;

//   static FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

//   // static String get env => getIt<ENV>().environment.name;

//   static Future<void> _listenToNotification() async {
//     await firebaseMessaging.subscribeToTopic("all");
//     // await firebaseMessaging.subscribeToTopic("${env}_app");
//   }

//   static Future<void> stopListeningToNotification({
//     required String uid,
//   }) async {
//     // await firebaseMessaging.unsubscribeFromTopic("${env}_$uid");
//     // await firebaseMessaging.unsubscribeFromTopic("${env}_app");
//   }

//   static void init({
//     // required String uid,
//     required BuildContext context,
//   }) async {
//     if (!_initialized) {
//       _initialized = true;

//       await firebaseMessaging.requestPermission();
//       if (Platform.isAndroid) {
//         await firebaseMessaging.getToken();
//       } else if (Platform.isIOS) {
//         await firebaseMessaging.getAPNSToken();
//       }
//       await firebaseMessaging.setAutoInitEnabled(true);
//       await firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       _listenToNotification();
//       FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
//       FirebaseMessaging.onMessage.listen(
//         (RemoteMessage message) {
//           if (message.notification != null) {
//             showInAppNotification(
//               message: message.notification!.body ?? "No message body",
//               title: message.notification!.title ?? "No title",
//             );
//           }
//         },
//       );
//     }
//   }
// }

// void showInAppNotification({
//   required String message,
//   required String title,
// }) {
//   showOverlayNotification(
//     (context) {
//       return SafeArea(
//         child: GestureDetector(
//           onTap: () {
//             OverlaySupportEntry.of(context)?.dismiss();
//           },
//           child: InAppNotification(
//             message: message,
//             title: title,
//           ),
//         ),
//       );
//     },
//     duration: const Duration(seconds: 3),
//   );
// }
