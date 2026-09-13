import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';
import 'add_task_page.dart';
import 'widgets/stat_card.dart';
import 'widgets/task_card.dart';
import 'widgets/task_detail_sheet.dart';

/// Screen 1: Home / Dashboard view displaying task statistics and task list.
class HomePage extends StatefulWidget {
  final TaskController controller;

  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = 'All'; // Filters: 'All', 'Pending', 'Completed'

  /// Navigates to Screen 2 - Add Task Page
  Future<void> _navigateToAddTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(controller: widget.controller),
      ),
    );

    if (newTask != null) {
      setState(() {}); // Rebuild UI to display newly added task
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task "${newTask.title}" added successfully!'),
            backgroundColor: AppTheme.secondaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  /// Opens Screen 3 - Task Information modal sheet
  void _openTaskDetails(Task task, int originalIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskDetailSheet(
        task: task,
        index: originalIndex,
        onToggleStatus: () {
          setState(() {
            widget.controller.changeStatus(originalIndex);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                task.completed
                    ? 'Task marked as Completed!'
                    : 'Task marked as Pending',
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        onDelete: () {
          setState(() {
            widget.controller.deleteTask(originalIndex);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Task "${task.title}" deleted'),
              backgroundColor: AppTheme.priorityHigh,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter tasks based on active selection tab
    final List<Task> filteredTasks = widget.controller.tasks.where((t) {
      if (_selectedFilter == 'Pending') return !t.completed;
      if (_selectedFilter == 'Completed') return t.completed;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Student Task Manager'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Dashboard Statistics Row (Total Tasks, Completed, Pending)
              Row(
                children: [
                  StatCard(
                    title: 'Total Tasks',
                    value: '${widget.controller.totalTasks}',
                    icon: Icons.assignment,
                    color: AppTheme.primaryColor,
                    backgroundColor: Colors.indigo.shade50,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    title: 'Completed',
                    value: '${widget.controller.completedTasks}',
                    icon: Icons.check_circle,
                    color: AppTheme.secondaryColor,
                    backgroundColor: Colors.teal.shade50,
                  ),
                  const SizedBox(width: 10),
                  StatCard(
                    title: 'Pending',
                    value: '${widget.controller.pendingTasks}',
                    icon: Icons.pending_actions,
                    color: AppTheme.priorityHigh,
                    backgroundColor: Colors.red.shade50,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Add New Task Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _navigateToAddTask,
                  icon: const Icon(Icons.add_rounded, size: 22),
                  label: const Text('[ Add New Task ]'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Header & Category / Filter Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Task List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  // Filter Segment Chips
                  Row(
                    children: ['All', 'Pending', 'Completed'].map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: ChoiceChip(
                          label: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: AppTheme.primaryColor,
                          backgroundColor: Colors.grey.shade200,
                          showCheckmark: false,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Task ListView.builder or Empty State
              Expanded(
                child: filteredTasks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.checklist_rtl_rounded,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No ${_selectedFilter == 'All' ? '' : _selectedFilter.toLowerCase()} tasks found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Tap "[ Add New Task ]" above to get started',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTasks.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          // Find original index in controller list
                          final originalIndex =
                              widget.controller.tasks.indexOf(task);

                          return TaskCard(
                            task: task,
                            onToggleStatus: () {
                              setState(() {
                                widget.controller.changeStatus(originalIndex);
                              });
                            },
                            onDelete: () {
                              setState(() {
                                widget.controller.deleteTask(originalIndex);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Task "${task.title}" deleted'),
                                  backgroundColor: AppTheme.priorityHigh,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            onTap: () => _openTaskDetails(task, originalIndex),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        backgroundColor: AppTheme.primaryColor,
        tooltip: 'Add Task',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
