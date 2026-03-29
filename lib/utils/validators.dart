class Validators {
  static String? requiredField(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? driveOrWebUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PDF link is required';
    }

    final uri = Uri.tryParse(value.trim());
    if (uri == null || !(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      return 'Enter a valid URL starting with http/https';
    }
    return null;
  }

  static List<String> buildKeywords({
    required String subject,
    required String course,
    required String year,
    required String college,
  }) {
    final raw = [subject, course, year, college].join(' ').toLowerCase();
    return raw
        .split(RegExp(r'\s+'))
        .where((item) => item.trim().isNotEmpty)
        .toSet()
        .toList();
  }
}
