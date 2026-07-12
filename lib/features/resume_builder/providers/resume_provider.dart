import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/resume_model.dart';

class ResumeNotifier extends StateNotifier<ResumeModel> {
  ResumeNotifier() : super(const ResumeModel());

  void updateName(String value) {
    state = state.copyWith(fullName: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateEducation(String value) {
    state = state.copyWith(education: value);
  }

  void updateSkills(String value) {
    state = state.copyWith(skills: value);
  }

  void updateExperience(String value) {
    state = state.copyWith(experience: value);
  }
}

final resumeProvider =
    StateNotifierProvider<ResumeNotifier, ResumeModel>(
  (ref) => ResumeNotifier(),
);