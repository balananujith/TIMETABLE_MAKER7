import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/timetable.png');


    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,

    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/timetable.png',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String scheduledTime,
  }) async {
    // Convert scheduledDate and scheduledTime to a single DateTime object
    final DateTime scheduledDateTime = DateTime(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      int.parse(scheduledTime.split(':')[0]),
      int.parse(scheduledTime.split(':')[1].split(' ')[0]),
    );

    // Calculate the difference between the scheduledDateTime and the current time
    final Duration difference = scheduledDateTime.difference(DateTime.now());

    // Calculate the difference in seconds
    final int seconds = difference.inSeconds;

    if (difference.isNegative) {
      // If the scheduledDateTime is in the past, show the notification immediately
      await showNotification(id, title, body, 0);
    } else {
      // Show the notification with the provided details after the calculated delay
      await showNotification(id, title, body, seconds);
    }
  }

}
