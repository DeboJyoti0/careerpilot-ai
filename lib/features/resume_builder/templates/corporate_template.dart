import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/models/resume_model.dart';

class CorporateTemplate {
  static pw.Page build(ResumeModel resume) {
    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      build: (_) => [

        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(18),
          color: PdfColors.blueGrey900,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

              pw.Text(
                resume.fullName,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 28,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Text(
                "${resume.email} | ${resume.phone}",
                style: const pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 11,
                ),
              ),

              pw.Text(
                resume.address,
                style: const pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        section("EXECUTIVE SUMMARY"),

        pw.Text(resume.summary),

        section("PROFESSIONAL EXPERIENCE"),

        ...resume.experience.map(
          (e) => listItem(e),
        ),

        section("EDUCATION"),

        ...resume.education.map(
          (e) => listItem(e),
        ),

        section("PROJECTS"),

        ...resume.projects.map(
          (e) => listItem(e),
        ),

        section("CORE SKILLS"),

        pw.Wrap(
          spacing: 8,
          runSpacing: 8,
          children: resume.skills.map((skill) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                color: PdfColors.blueGrey50,
                border: pw.Border.all(
                  color: PdfColors.blueGrey900,
                ),
              ),
              child: pw.Text(skill),
            );
          }).toList(),
        ),
      ],
    );
  }

  static pw.Widget section(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(8),
        color: PdfColors.blueGrey900,
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

  static pw.Widget listItem(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("• "),
          pw.Expanded(
            child: pw.Text(text),
          ),
        ],
      ),
    );
  }
}