import '../models/task.dart';

/// Pure Dart TaskController managing task list state and business logic according to pure MVC pattern.
/// Contains zero Flutter or Material dependencies.
class TaskController {
  final List<Task> tasks = [];

  TaskController() {
    _loadSampleTasks();
  }

  /// Pre-populates default academic tasks matching the assignment scenario:
  /// Total: 5 | Completed: 2 | Pending: 3
  void _loadSampleTasks() {
    tasks.addAll([
      Task(
        title: 'Research Paper Draft',
        category: 'Research',
        priority: 'High',
        completed: false,
      ),
      Task(
        title: 'Mobile App Architecture Lecture',
        category: 'Lecture',
        priority: 'Medium',
        completed: true,
      ),
      Task(
        title: 'Database Systems Exam Preparation',
        category: 'Exam',
        priority: 'High',
        completed: false,
      ),
      Task(
        title: 'UI/UX Interactive Prototype',
        category: 'Assignment',
        priority: 'Medium',
        completed: true,
      ),
      Task(
        title: 'Study Group Discussion',
        category: 'Personal',
        priority: 'Low',
        completed: false,
      ),
    ]);
  }

  /// Adds a new task to the task list.
  void addTask(Task task) {
    tasks.insert(0, task);
  }

  /// Deletes a task by index.
  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    }
  }

  /// Toggles task completion status (Completed <-> Pending).
  void changeStatus(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].completed = !tasks[index].completed;
    }
  }

  /// Total number of tasks
  int get totalTasks => tasks.length;

  /// Number of completed tasks
  int get completedTasks => tasks.where((t) => t.completed).length;

  /// Number of pending tasks
  int get pendingTasks => tasks.where((t) => !t.completed).length;
}
