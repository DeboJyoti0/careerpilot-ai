import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/resume_model.dart';

class ResumeNotifier extends StateNotifier<ResumeModel> {
  ResumeNotifier() : super(const ResumeModel());

  // Personal Info
  void updateName(String value) {
    state = state.copyWith(fullName: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value);
  }

  void updateLinkedIn(String value) {
    state = state.copyWith(linkedin: value);
  }

  void updateGithub(String value) {
    state = state.copyWith(github: value);
  }

  void updatePortfolio(String value) {
    state = state.copyWith(portfolio: value);
  }

  void updateSummary(String value) {
    state = state.copyWith(summary: value);
  }

  // Lists
  void addEducation(String value) {
    state = state.copyWith(
      education: [...state.education, value],
    );
  }

  void removeEducation(int index) {
    final list = [...state.education];
    list.removeAt(index);
    state = state.copyWith(education: list);
  }

  void addExperience(String value) {
    state = state.copyWith(
      experience: [...state.experience, value],
    );
  }

  void removeExperience(int index) {
    final list = [...state.experience];
    list.removeAt(index);
    state = state.copyWith(experience: list);
  }

  void addProject(String value) {
    state = state.copyWith(
      projects: [...state.projects, value],
    );
  }

  void removeProject(int index) {
    final list = [...state.projects];
    list.removeAt(index);
    state = state.copyWith(projects: list);
  }

  void addSkill(String value) {
    state = state.copyWith(
      skills: [...state.skills, value],
    );
  }

  void removeSkill(int index) {
    final list = [...state.skills];
    list.removeAt(index);
    state = state.copyWith(skills: list);
  }

  void addCertification(String value) {
    state = state.copyWith(
      certifications: [...state.certifications, value],
    );
  }

  void removeCertification(int index) {
    final list = [...state.certifications];
    list.removeAt(index);
    state = state.copyWith(certifications: list);
  }

  void addLanguage(String value) {
    state = state.copyWith(
      languages: [...state.languages, value],
    );
  }

  void removeLanguage(int index) {
    final list = [...state.languages];
    list.removeAt(index);
    state = state.copyWith(languages: list);
  }

  void setResume(ResumeModel resume) {
    state = resume;
  }

  void clearResume() {
    state = const ResumeModel();
  }
}

final resumeProvider =
    StateNotifierProvider<ResumeNotifier, ResumeModel>(
  (ref) => ResumeNotifier(),
);