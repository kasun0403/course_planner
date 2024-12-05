import 'package:course_planner/constants/colors.dart';
import 'package:course_planner/pages/main_screens/assignment_page.dart';
import 'package:course_planner/pages/main_screens/courses_page.dart';
import 'package:course_planner/pages/main_screens/main_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> pages = [
    MainPage(),
    CoursesPage(),
    AssignmentPage(),
  ];

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded), label: "Assignments")
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        elevation: 0,
      ),
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
    );
  }
}
