import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/models/resume_model.dart';

class ElegantTemplate {
  static pw.Page build(ResumeModel resume) {
    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 35,
      ),
      build: (_) => [

        pw.Center(
          child: pw.Column(
            children: [

              pw.Text(
                resume.fullName.toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 26,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                "${resume.email} • ${resume.phone}",
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
              ),

              pw.Text(
                resume.address,
                style: const pw.TextStyle(
                  fontSize: 11,
                ),
              ),

              pw.SizedBox(height: 12),

              pw.Divider(
                thickness: 1,
              ),
            ],
          ),
        ),

        section("PROFILE"),

        pw.Text(resume.summary),

        section("EDUCATION"),

        ...resume.education.map(item),

        section("EXPERIENCE"),

        ...resume.experience.map(item),

        section("PROJECTS"),

        ...resume.projects.map(item),

        section("SKILLS"),

        pw.Wrap(
          spacing: 8,
          runSpacing: 8,
          children: resume.skills.map((skill) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.grey700,
                ),
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Text(
                skill,
                style: const pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  static pw.Widget section(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        top: 20,
        bottom: 8,
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  static pw.Widget item(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
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