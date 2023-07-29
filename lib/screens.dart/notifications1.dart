import 'package:time_table_maker_app/db/db_helper.dart';
import 'package:time_table_maker_app/models/task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

Future<List<Map<String, dynamic>>> fetchSelectedFields() async {
  // Initialize the database
  await DBhelper.initDb();

  try {
    // Fetch only the required fields (id, title, note, date, startTime, endTime, remind, repeat, color, isCompleted, data)
    List<String> selectedFields = [
      'id',
      'title',
      'note',
      'date',
      'startTime',
      'endTime',
      'remind',
      'repeat',
      'color',
      'isCompleted',
      'data',
    ];

    // Query the database for the selected fields
    return await DBhelper.db!.query(DBhelper.tableName, columns: selectedFields);
  } catch (e) {
    print('Error while fetching data: $e');
    return [];
  }
}
Future<void> printSelectedFields() async {
  List<Map<String, dynamic>> selectedData = await fetchSelectedFields();
  for (var data in selectedData) {
    // Access the required fields
    int id = data['id'];
    String title = data['title'];
    String note = data['note'];
    String date = data['date'];
    String startTime = data['startTime'];
    String endTime = data['endTime'];
    int remind = data['remind'];
    String repeat = data['repeat'];
    int color = data['color'];
    int isCompleted = data['isCompleted'];
    String extraData = data['data'];

    // Do something with the fetched data
    print('ID: $id');
    print('Title: $title');
    print('Note: $note');
    print('Date: $date');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('Remind: $remind');
    print('Repeat: $repeat');
    print('Color: $color');
    print('Is Completed: $isCompleted');
    print('Extra Data: $extraData');
  }
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void scheduleNotification(DateTime startTime) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id', // Change this channel ID to a unique value for your app
    'Scheduled Notifications',
    'Hello',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID (change this for different notifications)
    'Task Reminder', // Notification title
    'Your task is starting now!', // Notification body
    tz.TZDateTime.from(startTime, tz.local), // Scheduled date and time
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}





