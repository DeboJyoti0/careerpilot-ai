class ResumeModel {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String linkedIn;
  final String github;
  final String portfolio;
  final String summary;

  final List<String> education;
  final List<String> experience;
  final List<String> skills;
  final List<String> projects;
  final List<String> certifications;
  final List<String> languages;

  const ResumeModel({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.linkedIn = '',
    this.github = '',
    this.portfolio = '',
    this.summary = '',
    this.education = const [],
    this.experience = const [],
    this.skills = const [],
    this.projects = const [],
    this.certifications = const [],
    this.languages = const [],
  });

  ResumeModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? address,
    String? linkedIn,
    String? github,
    String? portfolio,
    String? summary,
    List<String>? education,
    List<String>? experience,
    List<String>? skills,
    List<String>? projects,
    List<String>? certifications,
    List<String>? languages,
  }) {
    return ResumeModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      summary: summary ?? this.summary,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
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
      'linkedIn': linkedIn,
      'github': github,
      'portfolio': portfolio,
      'summary': summary,
      'education': education,
      'experience': experience,
      'skills': skills,
      'projects': projects,
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
      linkedIn: map['linkedIn'] ?? '',
      github: map['github'] ?? '',
      portfolio: map['portfolio'] ?? '',
      summary: map['summary'] ?? '',
      education: List<String>.from(map['education'] ?? []),
      experience: List<String>.from(map['experience'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
      projects: List<String>.from(map['projects'] ?? []),
      certifications: List<String>.from(map['certifications'] ?? []),
      languages: List<String>.from(map['languages'] ?? []),
    );
  }
}