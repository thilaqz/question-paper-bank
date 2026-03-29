import 'package:cloud_firestore/cloud_firestore.dart';

class PaperModel {
  PaperModel({
    required this.id,
    required this.subject,
    required this.semester,
    required this.course,
    required this.year,
    required this.college,
    required this.pdfUrl,
    required this.likes,
    required this.reportCount,
    required this.reported,
    required this.keywords,
    required this.userId,
    this.createdAt,
  });

  final String id;
  final String subject;
  final int semester;
  final String course;
  final String year;
  final String college;
  final String pdfUrl;
  final int likes;
  final int reportCount;
  final bool reported;
  final List<String> keywords;
  final String userId;
  final Timestamp? createdAt;

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'semester': semester,
      'course': course,
      'year': year,
      'college': college,
      'pdfUrl': pdfUrl,
      'likes': likes,
      'reportCount': reportCount,
      'reported': reported,
      'keywords': keywords,
      'userId': userId,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory PaperModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return PaperModel(
      id: doc.id,
      subject: data['subject'] as String? ?? '',
      semester: data['semester'] as int? ?? 1,
      course: data['course'] as String? ?? '',
      year: data['year'] as String? ?? '',
      college: data['college'] as String? ?? '',
      pdfUrl: data['pdfUrl'] as String? ?? '',
      likes: data['likes'] as int? ?? 0,
      reportCount: data['reportCount'] as int? ?? 0,
      reported: data['reported'] as bool? ?? false,
      keywords: List<String>.from(data['keywords'] as List? ?? []),
      userId: data['userId'] as String? ?? '',
      createdAt: data['createdAt'] as Timestamp?,
    );
  }
}
