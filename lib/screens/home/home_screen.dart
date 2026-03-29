import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.selectedCourse,
    required this.selectedSemester,
    required this.selectedSubject,
    required this.onChanged,
  });

  final String selectedCourse;
  final int? selectedSemester;
  final String selectedSubject;
  final void Function({required String course, required int? semester, required String subject}) onChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> courses = ['BSc CS', 'BCom', 'BA', 'BBA', 'BCA'];
  static const List<String> subjects = ['Data Structures', 'DBMS', 'Accounting', 'Economics', 'Maths'];

  late String _course;
  late int? _semester;
  late TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _course = widget.selectedCourse;
    _semester = widget.selectedSemester;
    _subjectController = TextEditingController(text: widget.selectedSubject);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    widget.onChanged(course: _course, semester: _semester, subject: _subjectController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filters updated')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Filter Question Papers', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _course.isEmpty ? null : _course,
          decoration: const InputDecoration(labelText: 'Course'),
          items: courses.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => setState(() => _course = value ?? ''),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          value: _semester,
          decoration: const InputDecoration(labelText: 'Semester'),
          items: List.generate(
            6,
            (index) => DropdownMenuItem(value: index + 1, child: Text('Semester ${index + 1}')),
          ),
          onChanged: (value) => setState(() => _semester = value),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _subjectController,
          decoration: InputDecoration(
            labelText: 'Subject',
            hintText: 'Type or pick e.g. DBMS',
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              onSelected: (value) => setState(() => _subjectController.text = value),
              itemBuilder: (_) => subjects.map((e) => PopupMenuItem(value: e, child: Text(e))).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _applyFilters,
          icon: const Icon(Icons.check),
          label: const Text('Apply Filters'),
        ),
        const SizedBox(height: 20),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Go to the Papers tab to view filtered results.\n'
              'Tip: Keep filters empty to view all papers.',
            ),
          ),
        ),
      ],
    );
  }
}
