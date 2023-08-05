import 'package:flutter/material.dart';
import 'package:time_table_maker_app/screens.dart/edit.dart';
import 'package:time_table_maker_app/screens.dart/view.dart';
import 'package:time_table_maker_app/screens.dart/notifications1.dart';
import '../controllers/task_controllers.dart';
import 'package:get/get.dart';
import 'package:time_table_maker_app/main.dart';
import 'package:time_table_maker_app/models/task.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    init();
  }

  // Use async function to wait for getTasks() to complete
  Future<void> init() async {
    await _taskController.getTasks();
    getTask(); // Call your function here when the widget is initialized
  }

  void getTask() {
    final DateTime now = DateTime.now();
    final String formattedNow = DateFormat('hh:mm a').format(now);

    for (var task in _taskController.taskList) {
      final String? startTime = task.startTime;
      final String? title = task.title;
      final String? note = task.note;
      final int? remind = task.remind;

      print('$title');
      if (startTime != null && title != null && note != null) {
        final String taskStartTime12Hrs = startTime;
        final Duration timeDifference = DateFormat('hh:mm a').parse(taskStartTime12Hrs).difference(DateFormat('hh:mm a').parse(formattedNow));
        final Duration remindDuration = remind != null ? Duration(minutes: remind) : Duration.zero; // Set a default value if remind is null
        print("time now: $now");
        print("timedifference : $timeDifference");
        if (timeDifference == remindDuration && timeDifference.isNegative == false) {
          showNotification(title,startTime);
        }
      }
    }
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      title: const Text('TIMETABLE MAKER APP'),
      backgroundColor: Colors.blue,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/timetable.png'),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return EditScreen();
                    },
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Edit TimeTable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ViewScreen();
                    },
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.view_list,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'View TimeTable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
