import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/services/pdf_service.dart';
import '../../../shared/models/resume_model.dart';

class AtsTemplate {
  static pw.Page build(ResumeModel resume) {
    final regular = PdfService.instance.regularFont;
    final bold = PdfService.instance.boldFont;

    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30),

      build: (context) => [

        // HEADER
        pw.Center(
          child: pw.Text(
            resume.fullName,
            style: pw.TextStyle(
              font: bold,
              fontSize: 28,
            ),
          ),
        ),

        pw.SizedBox(height: 6),

        pw.Center(
          child: pw.Text(
            "${resume.email} | ${resume.phone}",
            style: pw.TextStyle(
              font: regular,
              fontSize: 11,
            ),
          ),
        ),

        pw.Center(
          child: pw.Text(
            resume.address,
            style: pw.TextStyle(
              font: regular,
              fontSize: 11,
            ),
          ),
        ),

        pw.SizedBox(height: 18),

        pw.Divider(),

        // SUMMARY
        _heading("Professional Summary", bold),

        pw.Text(
          resume.summary,
          style: pw.TextStyle(
            font: regular,
            fontSize: 11,
          ),
        ),

        pw.SizedBox(height: 15),

        // EDUCATION
        _heading("Education", bold),

        ...resume.education.map(
          (e) => _listItem(e, regular),
        ),

        pw.SizedBox(height: 15),

        // EXPERIENCE
        _heading("Experience", bold),

        ...resume.experience.map(
          (e) => _listItem(e, regular),
        ),

        pw.SizedBox(height: 15),

        // PROJECTS
        _heading("Projects", bold),

        ...resume.projects.map(
          (e) => _listItem(e, regular),
        ),

        pw.SizedBox(height: 15),

        // SKILLS
        _heading("Skills", bold),

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
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.circular(4),
                border: pw.Border.all(
                  color: PdfColors.blue300,
                ),
              ),

              child: pw.Text(
                skill,
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 10,
                ),
              ),
            );

          }).toList(),
        ),
      ],
    );
  }

  static pw.Widget _heading(
    String text,
    pw.Font bold,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: bold,
          fontSize: 16,
        ),
      ),
    );
  }

  static pw.Widget _listItem(
    String text,
    pw.Font regular,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(
        bottom: 6,
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            "- ",
            style: pw.TextStyle(
              font: regular,
            ),
          ),

          pw.Expanded(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                font: regular,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}