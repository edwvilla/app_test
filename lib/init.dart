import 'package:app_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void initFCM() async {
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

Future<void> initializeRemoteNotifications({required bool debug}) async {
  await Firebase.initializeApp();
  // await AwesomeNotificationsFcm().initialize(
  //   onSilentDataHandle: (silentData) async {
  //     //TODO: Add logic
  //     return;
  //   },
  // );
}

Future<String> getFirebaseMessagingToken() async {
  String firebaseAppToken = '';
  // if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
  //   try {
  //     //TODO: Add get token
  //     // firebaseAppToken =
  //     //     await AwesomeNotificationsFcm().requestFirebaseAppToken();
  //   } catch (exception) {
  //     debugPrint('$exception');
  //   }
  // } else {
  //   debugPrint('Firebase is not available on this project');
  // }
  return firebaseAppToken;
}
