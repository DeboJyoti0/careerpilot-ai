import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/ats_service.dart';
import '../resume_builder/providers/resume_provider.dart';
import 'widgets/ats_score_card.dart';
import 'widgets/ats_section_card.dart';

class AtsScreen extends ConsumerStatefulWidget {
  const AtsScreen({super.key});

  @override
  ConsumerState<AtsScreen> createState() => _AtsScreenState();
}

class _AtsScreenState extends ConsumerState<AtsScreen> {
  bool loading = false;

  String rawResult = "";

  int score = 0;

  List<String> strengths = [];
  List<String> weaknesses = [];
  List<String> suggestions = [];

  Future<void> analyze() async {
    setState(() {
      loading = true;
    });

    final resume = ref.read(resumeProvider);

    final result =
        await ATSService.instance.analyzeResume(resume);

    if (!mounted) return;

    parseResult(result);

    setState(() {
      rawResult = result;
      loading = false;
    });
  }

  void parseResult(String text) {
    strengths.clear();
    weaknesses.clear();
    suggestions.clear();

    final scoreMatch =
        RegExp(r'ATS Score:\s*(\d+)').firstMatch(text);

    if (scoreMatch != null) {
      score = int.parse(scoreMatch.group(1)!);
    }

    String section = "";

    for (final line in text.split("\n")) {
      final value = line.trim();

      if (value.startsWith("Strength")) {
        section = "strength";
        continue;
      }

      if (value.startsWith("Weak")) {
        section = "weak";
        continue;
      }

      if (value.startsWith("Suggestion")) {
        section = "suggestion";
        continue;
      }

      if (value.startsWith("•") ||
          value.startsWith("-")) {
        final item = value
            .replaceAll("•", "")
            .replaceAll("-", "")
            .trim();

        if (item.isEmpty) continue;

        switch (section) {
          case "strength":
            strengths.add(item);
            break;

          case "weak":
            weaknesses.add(item);
            break;

          case "suggestion":
            suggestions.add(item);
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ATS Resume Analyzer"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.analytics),
                label: Text(
                  loading
                      ? "Analyzing..."
                      : "Analyze Resume",
                ),
                onPressed:
                    loading ? null : analyze,
              ),
            ),

            const SizedBox(height: 25),

            if (score > 0)
              ATSScoreCard(score: score),

            const SizedBox(height: 20),

            ATSSectionCard(
              title: "Strengths",
              icon: Icons.check_circle,
              color: Colors.green,
              items: strengths,
            ),

            ATSSectionCard(
              title: "Weaknesses",
              icon: Icons.warning,
              color: Colors.orange,
              items: weaknesses,
            ),

            ATSSectionCard(
              title: "Suggestions",
              icon: Icons.lightbulb,
              color: Colors.blue,
              items: suggestions,
            ),

            if (rawResult.isNotEmpty)
              ExpansionTile(
                title: const Text("Raw AI Response"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SelectableText(rawResult),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}