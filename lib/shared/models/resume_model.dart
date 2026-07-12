class ResumeModel {
  final String fullName;
  final String email;
  final String education;
  final String skills;
  final String experience;

  const ResumeModel({
    this.fullName = '',
    this.email = '',
    this.education = '',
    this.skills = '',
    this.experience = '',
  });

  ResumeModel copyWith({
    String? fullName,
    String? email,
    String? education,
    String? skills,
    String? experience,
  }) {
    return ResumeModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      experience: experience ?? this.experience,
    );
  }
}