import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/paper_model.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../utils/validators.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final _subjectController = TextEditingController();
  final _yearController = TextEditingController();
  final _collegeController = TextEditingController();
  final _pdfUrlController = TextEditingController();

  String _course = 'BSc CS';
  int _semester = 1;
  bool _saving = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _yearController.dispose();
    _collegeController.dispose();
    _pdfUrlController.dispose();
    super.dispose();
  }

  Future<void> _savePaper() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final firestore = context.read<FirestoreService>();
    final user = context.read<AuthProvider>().currentUser;

    final paper = PaperModel(
      id: '',
      subject: _subjectController.text.trim(),
      semester: _semester,
      course: _course,
      year: _yearController.text.trim(),
      college: _collegeController.text.trim(),
      pdfUrl: _pdfUrlController.text.trim(),
      likes: 0,
      reportCount: 0,
      reported: false,
      keywords: Validators.buildKeywords(
        subject: _subjectController.text,
        course: _course,
        year: _yearController.text,
        college: _collegeController.text,
      ),
      userId: user?.uid ?? '',
    );

    try {
      await firestore.addPaper(paper);
      if (!mounted) return;
      _formKey.currentState!.reset();
      setState(() {
        _course = 'BSc CS';
        _semester = 1;
      });
      _subjectController.clear();
      _yearController.clear();
      _collegeController.clear();
      _pdfUrlController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paper uploaded successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _subjectController,
              validator: (value) => Validators.requiredField(value, 'Subject'),
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _semester,
              items: List.generate(
                6,
                (index) => DropdownMenuItem(value: index + 1, child: Text('Semester ${index + 1}')),
              ),
              onChanged: (value) => setState(() => _semester = value ?? 1),
              decoration: const InputDecoration(labelText: 'Semester'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _course,
              items: const [
                DropdownMenuItem(value: 'BSc CS', child: Text('BSc CS')),
                DropdownMenuItem(value: 'BCom', child: Text('BCom')),
                DropdownMenuItem(value: 'BA', child: Text('BA')),
                DropdownMenuItem(value: 'BBA', child: Text('BBA')),
                DropdownMenuItem(value: 'BCA', child: Text('BCA')),
              ],
              onChanged: (value) => setState(() => _course = value ?? 'BSc CS'),
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _yearController,
              validator: (value) => Validators.requiredField(value, 'Year'),
              decoration: const InputDecoration(labelText: 'Year (e.g., 2024)'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _collegeController,
              validator: (value) => Validators.requiredField(value, 'College'),
              decoration: const InputDecoration(labelText: 'College'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pdfUrlController,
              validator: Validators.driveOrWebUrl,
              decoration: const InputDecoration(
                labelText: 'Google Drive / PDF URL',
                hintText: 'https://drive.google.com/...',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _saving ? null : _savePaper,
                icon: const Icon(Icons.cloud_upload_outlined),
                label: _saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Upload Paper'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
