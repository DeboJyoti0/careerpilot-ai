import 'package:google_generative_ai/google_generative_ai.dart';

import '../config/app_config.dart';

class AIService {
  AIService._();

  static final AIService instance = AIService._();

  late final GenerativeModel _model = GenerativeModel(
   model: 'gemini-3.1-flash-lite',
    apiKey: AppConfig.geminiApiKey,
  );

  Future<String> generateText(String prompt) async {
    try {
      final response = await _model.generateContent([
        Content.text(prompt),
      ]);

      final text = response.text;

      if (text == null || text.trim().isEmpty) {
        return "Unable to generate response.";
      }

      return text.trim();
    } on GenerativeAIException catch (e) {
      return "Gemini Error: ${e.message}";
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> generateResumeSummary({
    required String name,
    required List<String> skills,
    required List<String> education,
    required List<String> experience,
  }) async {
    final prompt = """
You are a professional resume writer.

Write a strong ATS-friendly professional summary.

Name:
$name

Education:
${education.join(", ")}

Experience:
${experience.join(", ")}

Skills:
${skills.join(", ")}

Rules:
- 70 to 100 words
- Professional
- No markdown
- No headings
- Third person is NOT allowed
- Start directly with the summary
""";

    return generateText(prompt);
  }

  Future<String> generateCoverLetter({
    required String name,
    required String company,
    required String role,
    required List<String> skills,
  }) async {
    final prompt = """
Write a professional ATS-friendly cover letter.

Candidate:
$name

Company:
$company

Role:
$role

Skills:
${skills.join(", ")}

Rules:
- Around 300 words
- Professional
- No markdown
- No headings
""";

    return generateText(prompt);
  }
}