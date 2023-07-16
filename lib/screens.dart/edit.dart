import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_table_maker_app/functions/functions.dart';
import 'package:time_table_maker_app/models/task.dart';
import 'package:time_table_maker_app/screens.dart/view.dart';
import 'package:time_table_maker_app/widgets/input_field_for_editscreen.dart';
import 'package:time_table_maker_app/widgets/button_for_editscreen.dart';
import '../controllers/task_controllers.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();

}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    super.initState();
    _checkTaskAlerts();

  }


  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = '9:30 PM';
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ADD TASK'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  title: 'Subject',
                  hint: 'Enter Subject',
                  controller: _titleController,
                ),
                MyInputField(
                  title: 'Description',
                  hint: 'Enter Subject Description',
                  controller: _noteController,
                ),
                MyInputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUser(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color',
                          style: titleStyle,
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          children: List<Widget>.generate(3, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? Color.fromARGB(255, 11, 2, 136)
                                      : index == 1
                                      ? Colors.pink
                                      : Colors.yellow[300],
                                  child: _selectedColor == index
                                      ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                      : Container(),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                    ButtonForEditScreen(
                      label: 'Create Task',
                      onTap: _validateData,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateData() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      final bool isDuplicate = await _taskController.checkDuplicateTask(
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
      );

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task with the same date and time already exists!'),
            backgroundColor: Colors.black,
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      } else {
        _addTaskToDb();
        Navigator.of(context).push(MaterialPageRoute(builder: (cxt) {
          return ViewScreen();


        }));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields are required!'),
          backgroundColor: Colors.black,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void _showTaskAlert(String title, String description, String startTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Start Time: $startTime'),
              SizedBox(height: 8.0),
              Text(description),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _checkTaskAlerts() {
    // Get the current time in 24-hour format
    final DateTime now = DateTime.now();
    final String formattedNow = DateFormat('HH:mm').format(now);
    print('Time Difference: $now');
    // Iterate over your tasks list and check if any task is starting soon
    for (var task in _taskController.taskList) {
      final String? startTime = task.startTime;
      final String? title = task.title;
      final String? note = task.note;

      if (startTime != null && title != null && note != null) {
        // Use taskStartTime24Hrs for calculating the time difference
        final String taskStartTime24Hrs = DateFormat('HH:mm').format(DateFormat('hh:mm a').parse(startTime));

        // Calculate the time difference between the task's start time and the current time
        final Duration timeDifference = DateFormat('HH:mm').parse(startTime).difference(DateFormat('HH:mm').parse(formattedNow));
        print('Time Difference: $timeDifference');

        // Show an alert box if the task is starting within a specified time frame (e.g., 5 minutes)
        if (timeDifference.inMinutes <= 5 && timeDifference.isNegative == false) {

             _handleTaskAlert(title, note, taskStartTime24Hrs);

        }
      }
    }
  }


  void _handleTaskAlert(String title, String description, String startTime) {
    // Optionally, you can add additional logic here before showing the alert box

    _showTaskAlert(title, description, startTime);
  }







  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    _checkTaskAlerts();
    print("My id is "+"$value");
  }

  Future<void> _getDateFromUser(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      print('Selected date: $_selectedDate');
    } else {
      print('No date selected');
    }
  }
  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.parse(_startTime))
          : TimeOfDay.fromDateTime(DateTime.parse(_endTime)),
    );

    if (pickedTime != null) {
      final DateTime currentTime = DateTime.now();
      final DateTime selectedTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      final String formattedTime = DateFormat('hh:mm a').format(selectedTime);
      if (isStartTime) {
        setState(() {
          _startTime = formattedTime;
        });
      } else {
        setState(() {
          _endTime = formattedTime;
        });
      }
    } else {
      print('Time Canceled');
    }
  }
}