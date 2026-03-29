import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/paper_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/paper_card.dart';

class PapersListScreen extends StatelessWidget {
  const PapersListScreen({
    super.key,
    required this.course,
    required this.semester,
    required this.subject,
  });

  final String course;
  final int? semester;
  final String subject;

  @override
  Widget build(BuildContext context) {
    final firestore = context.read<FirestoreService>();

    return StreamBuilder<List<PaperModel>>(
      stream: firestore.streamPapers(
        course: course.isEmpty ? null : course,
        semester: semester,
        subject: subject.isEmpty ? null : subject,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final papers = snapshot.data ?? [];
        if (papers.isEmpty) {
          return const Center(child: Text('No papers found for selected filters.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: papers.length,
          itemBuilder: (context, index) {
            final paper = papers[index];
            return PaperCard(
              paper: paper,
              onLike: () async {
                await firestore.likePaper(paper.id);
              },
              onReport: () async {
                await firestore.reportPaper(paper.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Paper reported. Thank you!')),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
