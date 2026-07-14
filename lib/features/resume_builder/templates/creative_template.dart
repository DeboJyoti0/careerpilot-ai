import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/models/resume_model.dart';

class CreativeTemplate {
  static pw.Page build(ResumeModel resume) {
    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (_) => [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            /// LEFT SIDEBAR
            pw.Container(
              width: 150,
              color: PdfColors.indigo,
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                  pw.Text(
                    resume.fullName,
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(height: 20),

                  pw.Text(
                    "CONTACT",
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(height: 10),

                  pw.Text(
                    resume.email,
                    style: const pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 10,
                    ),
                  ),

                  pw.SizedBox(height: 6),

                  pw.Text(
                    resume.phone,
                    style: const pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 10,
                    ),
                  ),

                  pw.SizedBox(height: 6),

                  pw.Text(
                    resume.address,
                    style: const pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 10,
                    ),
                  ),

                  pw.SizedBox(height: 25),

                  pw.Text(
                    "SKILLS",
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(height: 10),

                  ...resume.skills.map(
                    (e) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Text(
                        "• $e",
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// RIGHT CONTENT
            pw.Expanded(
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(25),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    section("PROFILE"),

                    pw.Text(resume.summary),

                    section("EDUCATION"),

                    ...resume.education.map(
                      (e) => pw.Bullet(text: e),
                    ),

                    section("EXPERIENCE"),

                    ...resume.experience.map(
                      (e) => pw.Bullet(text: e),
                    ),

                    section("PROJECTS"),

                    ...resume.projects.map(
                      (e) => pw.Bullet(text: e),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget section(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        top: 15,
        bottom: 8,
      ),
      child: pw.Container(
        padding: const pw.EdgeInsets.all(6),
        color: PdfColors.indigo100,
        child: pw.Text(
          title,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}