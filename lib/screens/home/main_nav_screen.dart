import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../papers/papers_list_screen.dart';
import '../search/search_screen.dart';
import '../upload/upload_screen.dart';
import 'home_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  String _course = '';
  int? _semester;
  String _subject = '';

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        selectedCourse: _course,
        selectedSemester: _semester,
        selectedSubject: _subject,
        onChanged: ({required String course, required int? semester, required String subject}) {
          setState(() {
            _course = course;
            _semester = semester;
            _subject = subject;
          });
        },
      ),
      PapersListScreen(course: _course, semester: _semester, subject: _subject),
      const SearchScreen(),
      const UploadScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('QBank'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => context.read<AuthProvider>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.filter_alt_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.description_outlined), label: 'Papers'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.upload_file_outlined), label: 'Upload'),
        ],
      ),
    );
  }
}
