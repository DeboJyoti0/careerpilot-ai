import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final TextEditingController summaryController;
  final VoidCallback? onGenerateAI;

  const SummaryCard({
    super.key,
    required this.summaryController,
    this.onGenerateAI,
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
                    "Example:\nPassionate Flutter Developer with experience in Firebase, Riverpod and modern UI development...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onGenerateAI,
                icon: const Icon(Icons.auto_awesome),
                label: const Text("Generate with AI"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}