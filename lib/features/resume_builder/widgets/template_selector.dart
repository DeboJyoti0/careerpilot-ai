import 'package:flutter/material.dart';

import '../models/resume_template.dart';
import 'template_card.dart';

class TemplateSelector extends StatefulWidget {
  final Function(ResumeTemplate) onSelected;

  const TemplateSelector({
    super.key,
    required this.onSelected,
  });

  @override
  State<TemplateSelector> createState() => _TemplateSelectorState();
}

class _TemplateSelectorState extends State<TemplateSelector> {
  int selectedIndex = 0;

  final List<ResumeTemplate> templates = const [
    ResumeTemplate(
      id: "ats",
      title: "ATS Professional",
      subtitle: "Software & Corporate Jobs",
      description:
          "Highly ATS-friendly resume for software engineers and corporate professionals.",
      atsScore: 98,
      recommended: true,
      preview: "",
    ),

    ResumeTemplate(
      id: "modern",
      title: "Modern",
      subtitle: "Clean & Stylish",
      description:
          "Elegant modern resume with balanced typography and spacing.",
      atsScore: 92,
      recommended: false,
      preview: "",
    ),

    ResumeTemplate(
      id: "creative",
      title: "Creative",
      subtitle: "Design & UI/UX",
      description:
          "Creative resume for designers, artists and UI/UX professionals.",
      atsScore: 82,
      recommended: false,
      preview: "",
    ),

    ResumeTemplate(
      id: "minimal",
      title: "Minimal",
      subtitle: "Simple & Elegant",
      description:
          "Minimal layout focused on readability and simplicity.",
      atsScore: 95,
      recommended: false,
      preview: "",
    ),

    ResumeTemplate(
      id: "corporate",
      title: "Corporate",
      subtitle: "Business Professionals",
      description:
          "Professional resume for managers, executives and business roles.",
      atsScore: 94,
      recommended: false,
      preview: "",
    ),

    ResumeTemplate(
      id: "elegant",
      title: "Elegant",
      subtitle: "Premium Style",
      description:
          "Luxury resume design with premium typography.",
      atsScore: 90,
      recommended: false,
      preview: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Choose Resume Template",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Select your preferred resume design.",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 20),

        ...List.generate(
          templates.length,
          (index) {
            return TemplateCard(
              template: templates[index],
              selected: selectedIndex == index,
              onTap: () {

                setState(() {
                  selectedIndex = index;
                });

                widget.onSelected(
                  templates[index],
                );
              },
            );
          },
        ),
      ],
    );
  }
}