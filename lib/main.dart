import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:time_table_maker_app/screens.dart/splash.dart';
import 'db/db_helper.dart';
import 'package:time_table_maker_app/screens.dart/edit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
