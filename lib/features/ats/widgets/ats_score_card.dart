import 'package:flutter/material.dart';

class ATSScoreCard extends StatelessWidget {
  final int score;

  const ATSScoreCard({
    super.key,
    required this.score,
  });

  Color get scoreColor {
    if (score >= 85) return Colors.green;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }

  String get label {
    if (score >= 85) return "Excellent";
    if (score >= 70) return "Good";
    if (score >= 50) return "Average";
    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "ATS Resume Score",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 10,
                    color: scoreColor,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),

                Column(
                  children: [
                    Text(
                      "$score",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                    const Text("/100"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Chip(
              backgroundColor: scoreColor.withValues(alpha: .15),
              label: Text(
                label,
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
