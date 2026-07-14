import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/ai_service.dart';
import '../features/resume_builder/providers/resume_provider.dart';
import 'package:flutter/material.dart';

class CoverLetterScreen extends ConsumerStatefulWidget {
  const CoverLetterScreen({super.key});

  @override
  ConsumerState<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState
    extends ConsumerState<CoverLetterScreen> {
  final companyController = TextEditingController();
  final roleController = TextEditingController();

  final coverLetterController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    companyController.dispose();
    roleController.dispose();
    coverLetterController.dispose();
    super.dispose();
  }
  Future<void> generateCoverLetter() async {
  if (companyController.text.trim().isEmpty ||
      roleController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter company and role."),
      ),
    );
    return;
  }

  setState(() {
    loading = true;
  });

  try {
  final resume = ref.read(resumeProvider);

  final letter = await AIService.instance.generateCoverLetter(
    name: resume.fullName,
    company: companyController.text.trim(),
    role: roleController.text.trim(),
    skills: resume.skills,
  );

  if (!mounted) return;

  coverLetterController.text = letter;
} catch (e) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.toString()),
    ),
  );
}
  setState(() {
    loading = false;
  });
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("AI Cover Letter"),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Generate an ATS-Friendly Cover Letter",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Enter the company and role. AI will generate a professional cover letter.",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 25),

          TextField(
            controller: companyController,
            decoration: const InputDecoration(
              labelText: "Company Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 18),

          TextField(
            controller: roleController,
            decoration: const InputDecoration(
              labelText: "Job Role",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.auto_awesome),
              label: Text(
                loading ? "Generating..." : "Generate Cover Letter",
              ),
             onPressed: loading ? null : generateCoverLetter,
            ),
          ),

          const SizedBox(height: 25),

          TextField(
            controller: coverLetterController,
            maxLines: 18,
            decoration: const InputDecoration(
              labelText: "Generated Cover Letter",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
  );
}
}