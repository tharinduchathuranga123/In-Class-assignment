import 'package:flutter/material.dart';
import 'controllers/task_controller.dart';
import 'theme/app_theme.dart';
import 'views/home_page.dart';

void main() {
  runApp(const StudentTaskManagerApp());
}

/// Root application widget configuring MaterialApp and overall app theme.
class StudentTaskManagerApp extends StatefulWidget {
  const StudentTaskManagerApp({super.key});

  @override
  State<StudentTaskManagerApp> createState() => _StudentTaskManagerAppState();
}

class _StudentTaskManagerAppState extends State<StudentTaskManagerApp> {
  // Initialize MVC TaskController
  late final TaskController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TaskController();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Task Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomePage(controller: _taskController),
    );
  }
}
