import '../../core/services/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../../shared/models/resume_model.dart';
import 'providers/resume_provider.dart';

import 'widgets/personal_info_card.dart';
import 'widgets/summary_card.dart';
import 'widgets/education_card.dart';
import 'widgets/experience_card.dart';
import 'widgets/project_card.dart';
import 'widgets/skills_card.dart';
import 'widgets/save_button.dart';

class ResumeBuilderScreen extends ConsumerStatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  ConsumerState<ResumeBuilderScreen> createState() =>
      _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState
    extends ConsumerState<ResumeBuilderScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final linkedinController = TextEditingController();
  final githubController = TextEditingController();
  final portfolioController = TextEditingController();
  final summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadResume();
    });
  }

  Future<void> loadResume() async {
    final user = AuthService.instance.currentUser;

    if (user == null) return;

    final data = await FirestoreService.instance.getResume(user.uid);

    if (data == null) return;

    final resume = ResumeModel.fromMap(data);

    ref.read(resumeProvider.notifier).loadResume(resume);

    nameController.text = resume.fullName;
    emailController.text = resume.email;
    phoneController.text = resume.phone;
    addressController.text = resume.address;
    linkedinController.text = resume.linkedIn;
    githubController.text = resume.github;
    portfolioController.text = resume.portfolio;
    summaryController.text = resume.summary;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    linkedinController.dispose();
    githubController.dispose();
    portfolioController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  Future<void> saveResume() async {
    final notifier = ref.read(resumeProvider.notifier);

    notifier.updateName(nameController.text);
    notifier.updateEmail(emailController.text);
    notifier.updatePhone(phoneController.text);
    notifier.updateAddress(addressController.text);
    notifier.updateLinkedIn(linkedinController.text);
    notifier.updateGithub(githubController.text);
    notifier.updatePortfolio(portfolioController.text);
    notifier.updateSummary(summaryController.text);

    final resume = ref.read(resumeProvider);

    final user = AuthService.instance.currentUser;

    if (user == null) return;

    await FirestoreService.instance.updateUser(
      user.uid,
      {
        'resume': resume.toMap(),
        'resumeCompleted': true,
      },
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Resume saved successfully 🎉"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(resumeProvider);
    final notifier = ref.read(resumeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Builder"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PersonalInfoCard(
              nameController: nameController,
              emailController: emailController,
              phoneController: phoneController,
              addressController: addressController,
              linkedinController: linkedinController,
              githubController: githubController,
              portfolioController: portfolioController,
            ),

            const SizedBox(height: 20),

            SummaryCard(
              summaryController: summaryController,
              onGenerateAI: () {},
            ),

            const SizedBox(height: 20),

            EducationCard(
              education: resume.education,
              onAdd: notifier.addEducation,
              onRemove: notifier.removeEducation,
            ),

            const SizedBox(height: 20),

            ExperienceCard(
              experience: resume.experience,
              onAdd: notifier.addExperience,
              onRemove: notifier.removeExperience,
            ),

            const SizedBox(height: 20),

            ProjectsCard(
              projects: resume.projects,
              onAdd: notifier.addProject,
              onRemove: notifier.removeProject,
            ),

            const SizedBox(height: 20),

            SkillsCard(
              skills: resume.skills,
              onAdd: notifier.addSkill,
              onRemove: notifier.removeSkill,
            ),

            const SizedBox(height: 30),

           Column(
  children: [
    SaveResumeButton(
      onPressed: saveResume,
    ),

    const SizedBox(height: 16),

    SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text(
          "Generate PDF",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          final resume = ref.read(resumeProvider);

          await PdfService.instance.previewResume(resume);
        },
      ),
    ),
  ],
),

const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}