import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/models/resume_model.dart';

class MinimalTemplate {
  static pw.Page build(ResumeModel resume) {
    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (_) => [

        pw.Text(
          resume.fullName,
          style: pw.TextStyle(
            fontSize: 30,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 6),

        pw.Text(
          "${resume.email} • ${resume.phone}",
          style: const pw.TextStyle(
            fontSize: 11,
            color: PdfColors.grey700,
          ),
        ),

        pw.Text(
          resume.address,
          style: const pw.TextStyle(
            fontSize: 11,
            color: PdfColors.grey700,
          ),
        ),

        pw.SizedBox(height: 25),

        divider(),

        title("SUMMARY"),

        body(resume.summary),

        divider(),

        title("EDUCATION"),

        ...resume.education.map(
          (e) => item(e),
        ),

        divider(),

        title("EXPERIENCE"),

        ...resume.experience.map(
          (e) => item(e),
        ),

        divider(),

        title("PROJECTS"),

        ...resume.projects.map(
          (e) => item(e),
        ),

        divider(),

        title("SKILLS"),

        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: resume.skills.map((skill) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Text(skill),
            );
          }).toList(),
        ),
      ],
    );
  }

  static pw.Widget divider() {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 18),
      child: pw.Divider(
        thickness: 0.8,
      ),
    );
  }

  static pw.Widget title(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget body(String text) {
    return pw.Text(
      text,
      style: const pw.TextStyle(
        fontSize: 11,
      ),
    );
  }

  static pw.Widget item(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        "• $text",
        style: const pw.TextStyle(fontSize: 11),
      ),
    );
  }
}