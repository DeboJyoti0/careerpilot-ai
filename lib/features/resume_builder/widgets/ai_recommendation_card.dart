import 'package:flutter/material.dart';

import '../../../shared/models/resume_model.dart';
import '../services/template_ai_service.dart';

class AIRecommendationCard extends StatelessWidget {
  final ResumeModel resume;

  const AIRecommendationCard({
    super.key,
    required this.resume,
  });

  @override
  Widget build(BuildContext context) {
    final recommendation =
        TemplateAIService.recommend(resume);

    return Card(
      elevation: 5,
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: const [
                Icon(
                  Icons.smart_toy,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  "CareerPilot AI Recommendation",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              recommendation.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              recommendation.description,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 18),

            LinearProgressIndicator(
              value: recommendation.atsScore / 100,
              minHeight: 10,
              borderRadius:
                  BorderRadius.circular(20),
            ),

            const SizedBox(height: 8),

            Text(
              "Confidence ${recommendation.atsScore}%",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(height: 30),

            const Text(
              "Why this template?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _reason(
              Icons.school,
              "Education matches technical roles",
            ),

            _reason(
              Icons.code,
              "Technical skills detected",
            ),

            _reason(
              Icons.folder,
              "Projects improve ATS ranking",
            ),

            _reason(
              Icons.work,
              "Professional formatting preferred",
            ),
          ],
        ),
      ),
    );
  }

  Widget _reason(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}