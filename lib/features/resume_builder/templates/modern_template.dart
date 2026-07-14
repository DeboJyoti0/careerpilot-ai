import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/models/resume_model.dart';

class ModernTemplate {
  static pw.MultiPage build(ResumeModel resume) {
    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),

      build: (context) => [

        // HEADER
        pw.Center(
          child: pw.Text(
            resume.fullName.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
        ),

        pw.SizedBox(height: 6),

        pw.Center(
          child: pw.Text(
            "${resume.email}   |   ${resume.phone}",
            style: const pw.TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        pw.Center(
          child: pw.Text(
            resume.address,
            style: const pw.TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        pw.Center(
          child: pw.Text(
            "${resume.github}   |   ${resume.linkedIn}",
            style: const pw.TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        pw.SizedBox(height: 18),

        pw.Divider(),

        // SUMMARY

        sectionTitle("PROFESSIONAL SUMMARY"),

        pw.Text(
          resume.summary,
          style: const pw.TextStyle(
            fontSize: 12,
            lineSpacing: 4,
          ),
        ),

        // EDUCATION

        sectionTitle("EDUCATION"),

        ...resume.education.map(
          (e) => bullet(e),
        ),

        // EXPERIENCE

        sectionTitle("EXPERIENCE"),

        ...resume.experience.map(
          (e) => bullet(e),
        ),

        // PROJECTS

        sectionTitle("PROJECTS"),

        ...resume.projects.map(
          (e) => bullet(e),
        ),

        // SKILLS

        sectionTitle("SKILLS"),

        pw.Wrap(
          spacing: 8,
          runSpacing: 8,
          children: resume.skills
              .map(
                (skill) => pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.circular(20),
                    border: pw.Border.all(
                      color: PdfColors.blue300,
                    ),
                  ),
                  child: pw.Text(
                    skill,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  static pw.Widget sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
      child: pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        color: PdfColors.blue900,
        child: pw.Text(
          title,
          style: pw.TextStyle(
            color: PdfColors.white,
            fontWeight: pw.FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static pw.Widget bullet(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "• ",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Expanded(
            child: pw.Text(text),
          ),
        ],
      ),
    );
  }
}