import 'package:time_table_maker_app/db/db_helper.dart';
import 'package:time_table_maker_app/models/task.dart';

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




