// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mess_management/views/common_issues.dart';
// import 'package:mess_management/views/feedback_page.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:mess_management/views/menu.dart';
//
// class NotificationServices {
//   NotificationServices();
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> requestNotificationPermission() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   void initNotifications(BuildContext context, RemoteMessage message) async {
//     var andriodIntializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosIntializationSettings = const DarwinInitializationSettings();
//     var intializationSetting = InitializationSettings(
//         android: andriodIntializationSettings, iOS: iosIntializationSettings);
//     await _flutterLocalNotificationsPlugin.initialize(intializationSetting,
//         onDidReceiveNotificationResponse: (payload) {
//       handleMessage(context, message);
//     });
//   }
//
//   Future<String> getToken() async {
//     String? token = await _messaging.getToken();
//     print(token);
//     return token!;
//   }
//
//   void FirebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (kDebugMode) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//       }
//       NotificationServices().initNotifications(context, message);
//       NotificationServices().showNotification(message);
//     });
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(10000).toString(),
//       "RGUKT notifications",
//       importance: Importance.max,
//     );
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             channel.id.toString(), channel.name.toString(),
//             channelDescription: "Channel Description",
//             importance: Importance.high,
//             priority: Priority.high,
//             ticker: 'ticker');
//     DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentSound: true,
//       presentBadge: true,
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);
//
//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(0, message.notification!.title,
//           message.notification!.body, notificationDetails);
//     });
//   }
//
//   void handleMessage(BuildContext context, RemoteMessage message) {
//     print(message.data['type']);
//     if(message.data['type']=="feedback")
//       {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => FeedbackPage()));
//       }
//     else if(message.data['type']=="menu")
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>MessMenuPage() ));
//       }
//     else if(message.data['type']=='issue')
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>CommonIssues() ));
//       }
//     else
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>MessMenuPage() ));
//       }
//   }
// }
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mess_management/views/common_issues.dart';
import 'package:mess_management/views/feedback_page.dart';
import 'package:mess_management/views/menu.dart';

class NotificationServices {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationServices();

  // Request notification permissions
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Initialize notifications
  void initNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        });
  }

  // Get device token
  Future<String> getToken() async {
    String? token = await _messaging.getToken();
    return token!;
  }

  // Initialize Firebase messaging
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      NotificationServices().initNotifications(context, message);
      NotificationServices().showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  // Show notifications
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "RGUKT notifications",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(), channel.name.toString(),
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }

  // Handle notification navigation
  void handleMessage(BuildContext context, RemoteMessage message) {
    print(message.data['type']);
    if (message.data['type'] == "feedback") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackPage()),
      );
    } else if (message.data['type'] == "menu") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessMenuPage()),
      );
    } else if (message.data['type'] == 'issue') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommonIssues()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessMenuPage()),
      );
    }
  }
}
