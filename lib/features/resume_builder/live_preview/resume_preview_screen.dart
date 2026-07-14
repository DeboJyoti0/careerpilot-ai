
import 'package:flutter/material.dart';

import '../../../shared/models/resume_model.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeModel resume;

  const ResumePreviewScreen({
    super.key,
    required this.resume,
  });

  Widget heading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget bulletList(List<String> items) {
    if (items.isEmpty) {
      return const Text(
        "Not Added",
        style: TextStyle(color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                resume.fullName.isEmpty
                    ? "Your Name"
                    : resume.fullName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(resume.email),

              Text(resume.phone),

              Text(resume.address),

              if (resume.linkedIn.isNotEmpty)
                Text(resume.linkedIn),

              if (resume.github.isNotEmpty)
                Text(resume.github),

              if (resume.portfolio.isNotEmpty)
                Text(resume.portfolio),

              const Divider(height: 30),

              heading("Summary"),

              Text(
                resume.summary.isEmpty
                    ? "Your professional summary..."
                    : resume.summary,
              ),

              heading("Education"),

              bulletList(resume.education),

              heading("Experience"),

              bulletList(resume.experience),

              heading("Projects"),

              bulletList(resume.projects),

              heading("Skills"),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: resume.skills
                    .map(
                      (e) => Chip(
                        label: Text(e),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}