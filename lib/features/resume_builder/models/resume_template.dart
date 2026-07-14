class ResumeTemplate {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final int atsScore;
  final bool recommended;
  final String preview;

  const ResumeTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.atsScore,
    required this.recommended,
    required this.preview,
  });
}