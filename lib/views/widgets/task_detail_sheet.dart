import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../theme/app_theme.dart';

/// Screen 3 Component: Displays detailed information about a selected task
/// with options to mark as Complete/Pending or Delete the task.
class TaskDetailSheet extends StatelessWidget {
  final Task task;
  final int index;
  final VoidCallback onToggleStatus;
  final VoidCallback onDelete;

  const TaskDetailSheet({
    super.key,
    required this.task,
    required this.index,
    required this.onToggleStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColor = AppTheme.getPriorityColor(task.priority);
    final categoryIcon = AppTheme.getCategoryIcon(task.category);

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAlignment.start,
        children: [
          // Drag indicator handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header title: Screen 3 - Task Information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 12),

          // Task Name / Title
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          // Category Row
          Row(
            children: [
              const Text(
                'Category: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Chip(
                avatar: Icon(categoryIcon, size: 16, color: AppTheme.primaryColor),
                label: Text(
                  task.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                side: BorderSide.none,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Priority Row
          Row(
            children: [
              const Text(
                'Priority: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Chip(
                label: Text(
                  task.priority,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
                backgroundColor: priorityColor.withOpacity(0.12),
                side: BorderSide.none,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Status Row
          Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: task.completed
                      ? AppTheme.secondaryColor.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.completed ? 'Completed' : 'Pending',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: task.completed
                        ? AppTheme.secondaryColor
                        : Colors.orange.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Action Buttons: [ Complete / Mark Pending ] and [ Delete ]
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    onToggleStatus();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    task.completed
                        ? Icons.undo_rounded
                        : Icons.check_circle_outline_rounded,
                  ),
                  label: Text(
                    task.completed ? 'Mark Pending' : 'Complete',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: task.completed
                        ? Colors.orange.shade700
                        : AppTheme.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.priorityHigh,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
