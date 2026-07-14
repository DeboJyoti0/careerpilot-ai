
import 'package:flutter/material.dart';

class ResumePreviewBuilder extends StatelessWidget {
  final String templateId;

  const ResumePreviewBuilder({
    super.key,
    required this.templateId,
  });

  @override
  Widget build(BuildContext context) {
    switch (templateId) {
      case "ats":
        return _atsPreview();

      case "modern":
        return _modernPreview();

      case "creative":
        return _creativePreview();

      case "minimal":
        return _minimalPreview();

      case "corporate":
        return _corporatePreview();

      case "elegant":
        return _elegantPreview();

      default:
        return _modernPreview();
    }
  }

  Widget _page({required Widget child}) {
    return Container(
      width: 90,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(alpha: .05),
          )
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: child,
    );
  }

  Widget _line({
    double width = double.infinity,
    double height = 4,
    Color color = Colors.grey,
  }) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _atsPreview() {
    return _page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line(width: 55, height: 7, color: Colors.black),
          const SizedBox(height: 4),
          _line(width: 70),
          _line(width: 65),
          const Divider(height: 10),
          _line(width: 55),
          _line(),
          _line(),
          const SizedBox(height: 4),
          _line(width: 45),
          _line(),
          _line(width: 50),
        ],
      ),
    );
  }

  Widget _modernPreview() {
    return _page(
      child: Row(
        children: [
          Container(
            width: 18,
            color: Colors.blue,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(width: 40, height: 7, color: Colors.black),
                const SizedBox(height: 5),
                _line(),
                _line(),
                _line(width: 45),
                const SizedBox(height: 5),
                _line(),
                _line(width: 55),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _creativePreview() {
    return _page(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.deepPurple,
          ),
          const SizedBox(height: 6),
          _line(width: 40, color: Colors.deepPurple),
          _line(width: 55),
          const SizedBox(height: 5),
          _line(),
          _line(),
          _line(width: 35),
        ],
      ),
    );
  }

  Widget _minimalPreview() {
    return _page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line(width: 55, color: Colors.black),
          const SizedBox(height: 10),
          _line(),
          _line(),
          _line(),
          _line(width: 50),
          const Spacer(),
          _line(width: 60),
        ],
      ),
    );
  }

  Widget _corporatePreview() {
    return _page(
      child: Column(
        children: [
          Container(
            height: 16,
            color: Colors.indigo,
          ),
          const SizedBox(height: 6),
          _line(width: 45),
          _line(),
          _line(),
          _line(width: 50),
          const Spacer(),
          _line(width: 65),
        ],
      ),
    );
  }

  Widget _elegantPreview() {
    return _page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _line(width: 50, color: Colors.brown),
          const SizedBox(height: 6),
          Container(
            width: 30,
            height: 1,
            color: Colors.brown,
          ),
          const SizedBox(height: 8),
          _line(),
          _line(),
          _line(width: 45),
          const Spacer(),
          _line(width: 55),
        ],
      ),
    );
  }
}