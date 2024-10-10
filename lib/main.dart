import 'package:financial_management_app/screens/main_screen.dart';
import 'package:financial_management_app/screens/splash_screen.dart';
import 'package:financial_management_app/services/database/core.dart';
import 'package:financial_management_app/services/database/user_database.dart';
import 'package:flutter/material.dart';


void main() {
  CoreDatabase().database();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void getMoneyList() {
    MainScreen.moneys.clear();
    UserDatabase().getMoney().then((value) {
      for (var element in value) {
        MainScreen.moneys.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "iranSans",
      ),
      title: 'اپلیکیشن مدیریت مالی',
      debugShowCheckedModeBanner: false,
      //home: MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(), // Define the home screen route
      },
    );
  }
}
