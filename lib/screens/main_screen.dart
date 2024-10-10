import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:financial_management_app/screens/home_screen.dart';
import 'package:financial_management_app/screens/info_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static List<User> moneys = <User>[];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget body = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.deepPurple.shade300,
          backgroundColor: Colors.deepPurple,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              if (index == 0) {
                body = const HomeScreen();
              } else {
                body = const InfoScreen();
              }
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(Icons.info, color: Colors.white),
          ],
        ),
        body: body,
      ),
    );
  }
}
