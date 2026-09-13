import 'package:flutter/material.dart';
import 'controllers/task_controller.dart';
import 'theme/app_theme.dart';
import 'views/home_page.dart';

void main() {
  runApp(const StudentTaskManagerApp());
}

/// Root application widget configuring MaterialApp and overall app theme.
class StudentTaskManagerApp extends StatelessWidget {
  const StudentTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate MVC TaskController
    final taskController = TaskController();

    return MaterialApp(
      title: 'Student Task Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomePage(controller: taskController),
    );
  }
}
