import 'package:flutter/material.dart';
import 'package:time_table_maker_app/screens.dart/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
 
  Future<void>gotoLogin() async{
    await Future.delayed(Duration(seconds:4),);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (cxt){
      return HomeScreen();
    },
     ),
      );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/timetable.png',
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'TimeTable Maker App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}