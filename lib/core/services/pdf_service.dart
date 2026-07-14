import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../shared/models/resume_model.dart';

import '../../features/resume_builder/templates/ats_template.dart';
import '../../features/resume_builder/templates/corporate_template.dart';
import '../../features/resume_builder/templates/creative_template.dart';
import '../../features/resume_builder/templates/elegant_template.dart';
import '../../features/resume_builder/templates/minimal_template.dart';
import '../../features/resume_builder/templates/modern_template.dart';

class PdfService {
  PdfService._();

  static final PdfService instance = PdfService._();

  late pw.Font regularFont;
  late pw.Font boldFont;

  bool _loaded = false;

  Future<void> _loadFonts() async {
    if (_loaded) return;

    regularFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Roboto-Regular.ttf"),
    );

    boldFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Roboto-Bold.ttf"),
    );

    _loaded = true;
  }

  pw.Page _buildTemplate(
    ResumeModel resume,
    String template,
  ) {
    switch (template) {
      case "ats":
        return AtsTemplate.build(resume);

      case "creative":
        return CreativeTemplate.build(resume);

      case "minimal":
        return MinimalTemplate.build(resume);

      case "corporate":
        return CorporateTemplate.build(resume);

      case "elegant":
        return ElegantTemplate.build(resume);

      case "modern":
      default:
        return ModernTemplate.build(resume);
    }
  }

  Future<File> generateResumePdf(
    ResumeModel resume,
    String template,
  ) async {
    await _loadFonts();

    final pdf = pw.Document();

    pdf.addPage(
      _buildTemplate(resume, template),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/CareerPilot_Resume.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> previewResume(
    ResumeModel resume,
    String template,
  ) async {
    await _loadFonts();

    final pdf = pw.Document();

    pdf.addPage(
      _buildTemplate(resume, template),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}