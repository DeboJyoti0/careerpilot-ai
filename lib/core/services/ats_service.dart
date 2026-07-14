import '../../shared/models/resume_model.dart';
import 'ai_service.dart';

class ATSService {
  ATSService._();

  static final ATSService instance = ATSService._();

  Future<String> analyzeResume(ResumeModel resume) async {
    final prompt = """
You are an ATS Resume Analyzer.

Analyze the resume below.

Name:
${resume.fullName}

Summary:
${resume.summary}

Education:
${resume.education.join("\n")}

Experience:
${resume.experience.join("\n")}

Projects:
${resume.projects.join("\n")}

Skills:
${resume.skills.join(", ")}

Return ONLY in this format:

ATS Score: XX/100

Strengths:
• point
• point
• point

Weaknesses:
• point
• point

Suggestions:
• point
• point
• point
""";

    return AIService.instance.generateText(prompt);
  }
}