import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/resume_provider.dart';

class ResumeBuilderScreen extends ConsumerStatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
ConsumerState<ResumeBuilderScreen> createState() =>
    _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends ConsumerState<ResumeBuilderScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    ref.watch(resumeProvider);
    final notifier = ref.read(resumeProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Builder"), centerTitle: true),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep < 3) {
            setState(() {
              currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(currentStep == 3 ? "Finish" : "Next"),
                ),
                const SizedBox(width: 12),
                if (currentStep > 0)
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: const Text("Back"),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text("Personal"),
            content: Column(
              children: [
                TextField(
                  onChanged: notifier.updateName,
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: notifier.updateEmail,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ],
            ),
          ),
          Step(
            title: Text("Education"),
            content: TextField(
              decoration: InputDecoration(labelText: "Highest Qualification"),
            ),
          ),
          Step(
            title: Text("Skills"),
            content: TextField(
              decoration: InputDecoration(labelText: "Skills"),
            ),
          ),
          Step(
            title: Text("Experience"),
            content: TextField(
              decoration: InputDecoration(labelText: "Work Experience"),
            ),
          ),
        ],
      ),
    );
  }
}
