import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/paper_model.dart';

class PaperCard extends StatelessWidget {
  const PaperCard({
    super.key,
    required this.paper,
    required this.onLike,
    required this.onReport,
  });

  final PaperModel paper;
  final VoidCallback onLike;
  final VoidCallback onReport;

  Future<void> _openPdf(BuildContext context) async {
    final uri = Uri.parse(paper.pdfUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(paper.subject, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text('Year: ${paper.year}'),
            Text('College: ${paper.college}'),
            Text('Course: ${paper.course} | Sem: ${paper.semester}'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () => _openPdf(context),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open PDF'),
                ),
                OutlinedButton.icon(
                  onPressed: onLike,
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  label: Text('Like (${paper.likes})'),
                ),
                OutlinedButton.icon(
                  onPressed: onReport,
                  icon: const Icon(Icons.flag_outlined),
                  label: Text('Report (${paper.reportCount})'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
