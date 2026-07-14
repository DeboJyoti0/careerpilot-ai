import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final TextEditingController summaryController;

  final VoidCallback? onGenerateAI;

  final bool isGenerating;

  const SummaryCard({
    super.key,
    required this.summaryController,
    this.onGenerateAI,
    this.isGenerating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎯 Professional Summary",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Write a short introduction about yourself that will appear at the top of your resume.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: summaryController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                    "Example:\nPassionate Flutter Developer with experience in Flutter, Firebase, Riverpod and modern UI development...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: isGenerating ? null : onGenerateAI,
                icon: isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  isGenerating
                      ? "Generating..."
                      : "Generate with AI",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}