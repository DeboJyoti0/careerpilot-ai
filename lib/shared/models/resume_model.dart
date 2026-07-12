class ResumeModel {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String linkedin;
  final String github;
  final String portfolio;
  final String summary;

  final List<String> education;
  final List<String> experience;
  final List<String> projects;
  final List<String> skills;
  final List<String> certifications;
  final List<String> languages;

  const ResumeModel({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.linkedin = '',
    this.github = '',
    this.portfolio = '',
    this.summary = '',
    this.education = const [],
    this.experience = const [],
    this.projects = const [],
    this.skills = const [],
    this.certifications = const [],
    this.languages = const [],
  });

  ResumeModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? address,
    String? linkedin,
    String? github,
    String? portfolio,
    String? summary,
    List<String>? education,
    List<String>? experience,
    List<String>? projects,
    List<String>? skills,
    List<String>? certifications,
    List<String>? languages,
  }) {
    return ResumeModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      summary: summary ?? this.summary,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      projects: projects ?? this.projects,
      skills: skills ?? this.skills,
      certifications: certifications ?? this.certifications,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'linkedin': linkedin,
      'github': github,
      'portfolio': portfolio,
      'summary': summary,
      'education': education,
      'experience': experience,
      'projects': projects,
      'skills': skills,
      'certifications': certifications,
      'languages': languages,
    };
  }

  factory ResumeModel.fromMap(Map<String, dynamic> map) {
    return ResumeModel(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      linkedin: map['linkedin'] ?? '',
      github: map['github'] ?? '',
      portfolio: map['portfolio'] ?? '',
      summary: map['summary'] ?? '',
      education: List<String>.from(map['education'] ?? []),
      experience: List<String>.from(map['experience'] ?? []),
      projects: List<String>.from(map['projects'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
      certifications: List<String>.from(map['certifications'] ?? []),
      languages: List<String>.from(map['languages'] ?? []),
    );
  }
}