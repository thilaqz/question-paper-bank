import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/paper_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _papers => _db.collection('papers');

  Future<void> addPaper(PaperModel paper) async {
    await _papers.add(paper.toMap());
  }

  Stream<List<PaperModel>> streamPapers({
    String? course,
    int? semester,
    String? subject,
  }) {
    Query<Map<String, dynamic>> query = _papers;

    if (course != null && course.isNotEmpty) {
      query = query.where('course', isEqualTo: course);
    }

    if (semester != null) {
      query = query.where('semester', isEqualTo: semester);
    }

    if (subject != null && subject.isNotEmpty) {
      query = query.where('subject', isEqualTo: subject);
    }

    return query.snapshots().map(
      (snapshot) => snapshot.docs.map(PaperModel.fromDoc).toList(),
    );
  }

  Stream<List<PaperModel>> searchPapers(String term) {
    final formatted = term.trim().toLowerCase();
    if (formatted.isEmpty) {
      return const Stream.empty();
    }

    return _papers
        .where('keywords', arrayContains: formatted)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(PaperModel.fromDoc).toList());
  }

  Future<void> likePaper(String id) async {
    await _papers.doc(id).update({'likes': FieldValue.increment(1)});
  }

  Future<void> reportPaper(String id) async {
    await _papers.doc(id).update({
      'reportCount': FieldValue.increment(1),
      'reported': true,
    });
  }
}
