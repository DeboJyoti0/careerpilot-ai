
import 'package:go_router/go_router.dart';
import '../../core/services/ai_service.dart';
import 'live_preview/resume_preview_screen.dart';
import 'widgets/ai_recommendation_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../../core/services/pdf_service.dart';

import '../../shared/models/resume_model.dart';

import 'models/resume_template.dart';
import 'providers/resume_provider.dart';

import 'widgets/template_selector.dart';
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

class _ResumeBuilderScreenState extends ConsumerState<ResumeBuilderScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final linkedinController = TextEditingController();
  final githubController = TextEditingController();
  final portfolioController = TextEditingController();
  final summaryController = TextEditingController();

  ResumeTemplate selectedTemplate = const ResumeTemplate(
    id: "ats",
    title: "ATS Professional",
    subtitle: "Software & Corporate Jobs",
    description: "",
    atsScore: 98,
    recommended: true,
    preview: "",
  );
  bool isGeneratingSummary = false;

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

    debugPrint("========== RESUME DATA ==========");
    debugPrint("Template: ${selectedTemplate.id}");
    debugPrint("Name: ${resume.fullName}");
    debugPrint("Education: ${resume.education}");
    debugPrint("Experience: ${resume.experience}");
    debugPrint("Projects: ${resume.projects}");
    debugPrint("Skills: ${resume.skills}");
    debugPrint("================================");

    final user = AuthService.instance.currentUser;

    if (user == null) return;

    await FirestoreService.instance.updateUser(user.uid, {
      "resume": resume.toMap(),
      "resumeCompleted": true,
      "selectedTemplate": selectedTemplate.id,
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resume saved successfully 🎉")),
      );
    }
  }

  Future<void> generateAISummary() async {
    setState(() {
      isGeneratingSummary = true;
    });

    try {
      final resume = ref.read(resumeProvider);

      final summary = await AIService.instance.generateResumeSummary(
        name: nameController.text,
        skills: resume.skills,
        education: resume.education,
        experience: resume.experience,
      );

      summaryController.text = summary;

      ref.read(resumeProvider.notifier).updateSummary(summary);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("AI Summary Generated ✨")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    setState(() {
      isGeneratingSummary = false;
    });
  }

  Widget _buildForm(ResumeModel resume, ResumeNotifier notifier) {
    return Column(
      children: [
        AIRecommendationCard(resume: resume),

        const SizedBox(height: 20),

        TemplateSelector(
          onSelected: (template) {
            setState(() {
              selectedTemplate = template;
            });
          },
        ),

        const SizedBox(height: 25),

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
          isGenerating: isGeneratingSummary,
          onGenerateAI: generateAISummary,
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

        SaveResumeButton(onPressed: saveResume),
        const SizedBox(height: 16),

        SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.auto_awesome),
    label: const Text(
      "AI Cover Letter",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      context.push('/cover-letter');
    },
  ),
),

const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text(
              "Generate PDF",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final resume = ref.read(resumeProvider);

              debugPrint("========== PDF ==========");
              debugPrint("Template: ${selectedTemplate.id}");
              debugPrint("Name: ${resume.fullName}");
              debugPrint("Education: ${resume.education}");
              debugPrint("Experience: ${resume.experience}");
              debugPrint("Projects: ${resume.projects}");
              debugPrint("Skills: ${resume.skills}");
              debugPrint("=========================");

              await PdfService.instance.previewResume(
                resume,
                selectedTemplate.id,
              );
            },
          ),
        ),
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.analytics),
    label: const Text(
      "ATS Resume Analyzer",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      context.push('/ats');
    },
  ),
),

const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(resumeProvider);
    final notifier = ref.read(resumeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Resume Builder"), centerTitle: true),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1100;

          if (isDesktop) {
            return Row(
              children: [
                /// LEFT SIDE - FORM
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: _buildForm(resume, notifier),
                  ),
                ),

                Container(width: 1, color: Colors.grey.shade300),

                /// RIGHT SIDE - LIVE PREVIEW
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Live Resume Preview",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Expanded(child: ResumePreviewScreen(resume: resume)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          /// MOBILE
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildForm(resume, notifier),

                const SizedBox(height: 30),

                const Divider(),

                const SizedBox(height: 20),

                const Text(
                  "Live Resume Preview",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                ResumePreviewScreen(resume: resume),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
