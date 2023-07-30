import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_table_maker_app/db/db_helper.dart';

import 'package:time_table_maker_app/controllers/task_controllers.dart';
import 'package:time_table_maker_app/models/task.dart';
import 'package:time_table_maker_app/screens.dart/notifications1.dart';
class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final _taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
  }
  void resetDatabase() {
    DBhelper.resetDatabase();
    _taskController.getTasks(); // Reload tasks after resetting the database
  }

  Task task = Task();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'Today',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.blue,
                  selectedTextColor: Colors.white,
                  dateTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  dayTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  monthTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },

                ),

              ),
            ),
            // Add Reset Database button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: resetDatabase,
                child: Text('Reset Database'),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
              child: Obx(() {
                return Table(
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                'Subject',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                'Start Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                'End Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                'Actions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          ),
                        ), //
                      ],
                    ),

                    //getData can be used here to iterate for a single or multiple dates
                    for (var task in _taskController.taskList)
                      if(task.date==DateFormat.yMd().format(selectedDate))
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 50,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    task.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 50,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    task.startTime.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 50,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    task.endTime.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 50,
                                color: Colors.green,
                                child: IconButton(
                                  onPressed: () => _taskController.removeTask(task),
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                );
              }),
    ),
            )
          ],
        )

    );
  }
}
