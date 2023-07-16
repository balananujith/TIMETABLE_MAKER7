import 'package:get/get.dart';
import '../db/db_helper.dart';
import '../models/task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    int result = await DBhelper.insert(task);
    if (result != -1) {
      print('Task added successfully');

    } else {
      print('Failed to add task');
    }
    return result;
  }


  Future<bool> checkDuplicateTask({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    final List<Task> tasks = await getTasks(); // Retrieve the list of tasks from the database

    for (final task in tasks) {
      if (task.date == date && task.startTime == startTime && task.endTime == endTime) {
        return true; // Task with the same date and time already exists
      }

    }

    return false; // No duplicate task found
  }

  Future<void> removeTask(Task task) async {
    int result = await DBhelper.delete(task.id);
    if (result != -1) {
      print('Task removed successfully');
      taskList.remove(task);
    } else {
      print('Failed to remove task');
    }
  }

  Future<List<Task>> getTasks() async {
    List<Map<String, dynamic>> tasksData = await DBhelper.query();
    List<Task> fetchedTasks =
    tasksData.map((data) => Task.fromJson(data)).toList();
    taskList.assignAll(fetchedTasks);
    return fetchedTasks;
  }
}
