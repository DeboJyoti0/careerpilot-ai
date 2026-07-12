import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../shared/models/resume_model.dart';

class PdfService {
  PdfService._();

  static final PdfService instance = PdfService._();

  Future<File> generateResumePdf(ResumeModel resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Center(
            child: pw.Text(
              resume.fullName,
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 8),

          pw.Center(
            child: pw.Text(
              "${resume.email} | ${resume.phone}",
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),

          pw.Center(
            child: pw.Text(
              resume.address,
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),

          pw.Divider(),

          pw.SizedBox(height: 12),

          pw.Text(
            "Professional Summary",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Text(resume.summary),

          pw.SizedBox(height: 20),

          pw.Text(
            "Education",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          ...resume.education.map((e) => pw.Bullet(text: e)),

          pw.SizedBox(height: 20),

          pw.Text(
            "Experience",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          ...resume.experience.map((e) => pw.Bullet(text: e)),

          pw.SizedBox(height: 20),

          pw.Text(
            "Projects",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          ...resume.projects.map((e) => pw.Bullet(text: e)),

          pw.SizedBox(height: 20),

          pw.Text(
            "Skills",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Wrap(
            spacing: 8,
            runSpacing: 8,
            children: resume.skills
                .map(
                  (e) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blue100,
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(e),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/CareerPilot_Resume.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  Future<void> previewResume(ResumeModel resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Text(
            resume.fullName,
            style: pw.TextStyle(
              fontSize: 30,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}