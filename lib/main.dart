
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_table_maker_app/screens.dart/splash.dart';
import 'db/db_helper.dart';
import 'package:time_table_maker_app/screens.dart/edit.dart';
import 'package:time_table_maker_app/screens.dart/notifications1.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDb();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize local notifications
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Function to show local notification
void showNotification(String title,String startTime) {
  flutterLocalNotificationsPlugin.show(
    1,
    title,
    "Your task starting at: $startTime",
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channel.description,
        color: Colors.blue,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      ),
    ),
  );
}