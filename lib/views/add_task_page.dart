import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

/// Screen 2: Add Task View with form validation, category picker, and priority selection.
class AddTaskPage extends StatefulWidget {
  final TaskController controller;

  const AddTaskPage({super.key, required this.controller});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  // Category and priority options
  final List<String> _categories = [
    'Assignment',
    'Lecture',
    'Research',
    'Exam',
    'Personal'
  ];
  final List<String> _priorities = ['High', 'Medium', 'Low'];

  String _selectedCategory = 'Assignment';
  String _selectedPriority = 'Medium';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  /// Validates input and adds task to controller
  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();

      final newTask = Task(
        title: title,
        category: _selectedCategory,
        priority: _selectedPriority,
        completed: false,
      );

      // Add task via MVC controller
      widget.controller.addTask(newTask);

      // Return to Screen 1 (Home)
      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title: Task Name
                const Text(
                  'Task Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                // TextFormField with validation (Prevent Empty Task Submission)
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Complete Mobile App Research Paper',
                    prefixIcon: Icon(Icons.edit_note_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task name (Task title cannot be empty)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Section Title: Category Selection
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                // Category Selection Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    final categoryIcon = AppTheme.getCategoryIcon(category);

                    return ChoiceChip(
                      avatar: Icon(
                        categoryIcon,
                        size: 18,
                        color: isSelected
                            ? Colors.white
                            : AppTheme.primaryColor,
                      ),
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey.shade800,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Section Title: Priority Selection
                const Text(
                  'Priority',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                // Priority Choice Chips
                Row(
                  children: _priorities.map((priority) {
                    final isSelected = _selectedPriority == priority;
                    final priorityColor = AppTheme.getPriorityColor(priority);

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Center(
                            child: Text(
                              priority,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : priorityColor,
                              ),
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: priorityColor,
                          backgroundColor: priorityColor.withValues(alpha: 0.1),
                          showCheckmark: false,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedPriority = priority;
                              });
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),

                // Submit Button: [ Add Task ]
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submitTask,
                    icon: const Icon(Icons.check_circle_rounded),
                    label: const Text('[ Add Task ]'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
