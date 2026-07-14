import '../models/resume_template.dart';
import '../../../shared/models/resume_model.dart';

class TemplateAIService {
  static ResumeTemplate recommend(ResumeModel resume) {
    final skills =
        resume.skills.join(" ").toLowerCase();

    final projects =
        resume.projects.join(" ").toLowerCase();

    final experience =
        resume.experience.length;

    final education =
        resume.education.join(" ").toLowerCase();

    // Software / Tech
    if (skills.contains("flutter") ||
        skills.contains("java") ||
        skills.contains("python") ||
        skills.contains("react") ||
        skills.contains("firebase") ||
        projects.contains("app") ||
        education.contains("computer")) {
      return const ResumeTemplate(
        id: "ats",
        title: "ATS Professional",
        subtitle: "AI Recommendation",
        description:
            "Best for software developers and freshers.",
        atsScore: 98,
        recommended: true,
        preview: "",
      );
    }

    // Experienced professionals
    if (experience >= 3) {
      return const ResumeTemplate(
        id: "corporate",
        title: "Corporate",
        subtitle: "AI Recommendation",
        description:
            "Perfect for experienced professionals.",
        atsScore: 95,
        recommended: true,
        preview: "",
      );
    }

    // Designers
    if (skills.contains("figma") ||
        skills.contains("photoshop") ||
        skills.contains("illustrator") ||
        skills.contains("ui")) {
      return const ResumeTemplate(
        id: "creative",
        title: "Creative",
        subtitle: "AI Recommendation",
        description:
            "Ideal for UI/UX and creative roles.",
        atsScore: 84,
        recommended: true,
        preview: "",
      );
    }

    // Default
    return const ResumeTemplate(
      id: "modern",
      title: "Modern",
      subtitle: "AI Recommendation",
      description:
          "Balanced layout suitable for most roles.",
      atsScore: 92,
      recommended: true,
      preview: "",
    );
  }
}