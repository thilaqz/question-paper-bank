import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/paper_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/paper_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = context.read<FirestoreService>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by subject or keyword',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => _query = _searchController.text),
              ),
            ),
            onSubmitted: (value) => setState(() => _query = value),
          ),
        ),
        Expanded(
          child: _query.trim().isEmpty
              ? const Center(child: Text('Enter a keyword to search papers.'))
              : StreamBuilder<List<PaperModel>>(
                  stream: firestore.searchPapers(_query),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final papers = snapshot.data ?? [];
                    if (papers.isEmpty) {
                      return const Center(child: Text('No matching papers found.'));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: papers.length,
                      itemBuilder: (context, index) {
                        final paper = papers[index];
                        return PaperCard(
                          paper: paper,
                          onLike: () => firestore.likePaper(paper.id),
                          onReport: () => firestore.reportPaper(paper.id),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
