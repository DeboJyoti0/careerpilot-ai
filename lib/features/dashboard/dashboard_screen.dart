import 'package:go_router/go_router.dart'; // Add this at the top if not already present
import 'package:flutter/material.dart';

import 'widgets/ai_assistant_card.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/progress_card.dart';
import 'widgets/quick_action_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF7F9FC), Color(0xFFEAF2FF), Color(0xFFFDFDFF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),

                const SizedBox(height: 30),

                const ProgressCard(),

                const SizedBox(height: 24),

                const AiAssistantCard(),

                const SizedBox(height: 30),

                Row(
                  children: [
                    QuickActionCard(
                      icon: Icons.description_outlined,
                      title: "Resume",
                      subtitle: "Build and edit your professional resume.",
                      color: Colors.blue,
                      onTap: () {
                        context.push('/resume');
                      },
                    ),
                    const SizedBox(width: 16),
                    QuickActionCard(
                      icon: Icons.analytics_outlined,
                      title: "ATS Score",
                      subtitle: "Analyze your resume for ATS compatibility.",
                      color: Colors.green,
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    QuickActionCard(
                      icon: Icons.work_outline,
                      title: "Jobs",
                      subtitle: "Discover jobs matched to your skills.",
                      color: Colors.orange,
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    QuickActionCard(
                      icon: Icons.record_voice_over_outlined,
                      title: "Interview",
                      subtitle: "Practice AI-powered mock interviews.",
                      color: Colors.deepPurple,
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
