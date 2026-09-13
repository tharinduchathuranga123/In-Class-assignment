import 'package:flutter_test/flutter_test.dart';
import 'package:student_task_manager/controllers/task_controller.dart';
import 'package:student_task_manager/models/task.dart';

void main() {
  group('TaskController MVC Unit Tests', () {
    late TaskController controller;

    setUp(() {
      controller = TaskController();
    });

    test('Initial sample state matches scenario (Total: 5, Completed: 2, Pending: 3)', () {
      expect(controller.totalTasks, equals(5));
      expect(controller.completedTasks, equals(2));
      expect(controller.pendingTasks, equals(3));
    });

    test('addTask adds a new task and updates metrics correctly', () {
      final newTask = Task(
        title: 'Submit Machine Learning Assignment',
        category: 'Assignment',
        priority: 'High',
        completed: false,
      );

      controller.addTask(newTask);

      expect(controller.totalTasks, equals(6));
      expect(controller.pendingTasks, equals(4));
      expect(controller.tasks.first.title, equals('Submit Machine Learning Assignment'));
    });

    test('changeStatus toggles completed status and updates pending/completed counts', () {
      final initialCompleted = controller.completedTasks;
      final initialPending = controller.pendingTasks;

      // Toggle status of first pending task (index 0)
      expect(controller.tasks[0].completed, isFalse);
      controller.changeStatus(0);

      expect(controller.tasks[0].completed, isTrue);
      expect(controller.completedTasks, equals(initialCompleted + 1));
      expect(controller.pendingTasks, equals(initialPending - 1));
    });

    test('deleteTask removes task from list by index', () {
      final initialTotal = controller.totalTasks;
      final taskToDelete = controller.tasks[0];

      controller.deleteTask(0);

      expect(controller.totalTasks, equals(initialTotal - 1));
      expect(controller.tasks.contains(taskToDelete), isFalse);
    });
  });
}
