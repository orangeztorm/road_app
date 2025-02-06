// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotificationHelper {
//   static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   static Future<void> _firebaseMessagingBackgroundHandler(
//     RemoteMessage message,
//   ) async {
//     log(message.data.toString());
//     log('Handling a background message ${message.messageId}'.toString());
//     log('back ground running...'.toString());

//     // Get.toNamed('/notification');
//   }

//   static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for notifications.',
//     importance: Importance.high,
//   );

//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static const AndroidInitializationSettings _initialzationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   static const InitializationSettings _initializationSettings =
//       InitializationSettings(android: _initialzationSettingsAndroid);

//   Future<void> initNotification() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_channel);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     _flutterLocalNotificationsPlugin.initialize(_initializationSettings);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final RemoteNotification? notification = message.notification;
//       log(notification!.title.toString());
//       log(notification.body.toString());
//       final AndroidNotification? android = message.notification?.android;

//       if (android != null) {
//         _flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               _channel.id,
//               _channel.name,
//               channelDescription: _channel.description,
//               icon: android.smallIcon,
//             ),
//           ),
//           // accountController.newNotification.value = true;
//         );
//       }
//     });

//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       if (message != null) {
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android!;

//         if (notification != null && android != null) {
//           _flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 _channel.id,
//                 _channel.name,
//                 channelDescription: _channel.description,
//                 icon: "@mipmap/ic_notification_launcher",
//               ),
//             ),
//           );
//           // accountController.newNotification.value = true;
//         }
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       log('A new onMessageOpenedApp event was published!');

//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android!;
//       if (notification != null && android != null) {
//         _flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 _channel.id,
//                 _channel.name,
//                 channelDescription: _channel.description,
//                 icon: "@mipmap/ic_notification_launcher",
//               ),
//             ));
//         // accountController.newNotification.value = true;
//       }
//     });

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     await firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }

//   Future<void> subscribeToTopic(String topic) async {
//     await firebaseMessaging.subscribeToTopic(topic);
//   }

//   Future<void> unsubscribeToTopic(String topic) async {
//     await firebaseMessaging.unsubscribeFromTopic(topic);
//   }

//   Future<String?> getFCMToken() async {
//     return await firebaseMessaging.getToken();
//   }
// }
