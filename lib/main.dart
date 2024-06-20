import 'package:app_test/contact_seller/contact_seller_controller.dart';
import 'package:app_test/firebase_options.dart';
import 'package:app_test/home/home_controller.dart';
import 'package:app_test/home/home_page.dart';
import 'package:app_test/init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initFCM();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ContactSellerController()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
