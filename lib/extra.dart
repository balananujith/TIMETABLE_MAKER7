/* 
class _TimetableScreenState extends State<TimetableScreen> {
  TextEditingController nameController = TextEditingController();
  List<String> subjects = [];
  List<String> timetable = [];

  void _generateTimetable() {
    // Clear the previous timetable
    timetable.clear();

    // Generate the timetable based on user inputs (e.g., subjects)
    // You can implement your own algorithm or logic here
    // For this example, let's assume a simple timetable structure
    timetable.add('Monday: 9 AM - ${subjects[0]}');
    timetable.add('Tuesday: 10 AM - ${subjects[1]}');
    timetable.add('Wednesday: 11 AM - ${subjects[2]}');

    // Update the UI to display the generated timetable
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Timetable')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your subjects:'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter a subject',
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  subjects.add(nameController.text);
                  nameController.clear();
                });
              },
              child: Text('Add Subject'),
            ),
            SizedBox(height: 20.0),
            Text('Subjects added:'),
            Column(
              children: subjects.map((subject) => Text(subject)).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _generateTimetable,
              child: Text('Generate Timetable'),
            ),
            SizedBox(height: 20.0),
            Text('Generated Timetable:'),
            Column(
              children: timetable.map((entry) => Text(entry)).toList(),
            ),
          ],
        ),
      ),
    );
  }
} */