import 'package:flutter/material.dart';

class SaveResumeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveResumeButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save),
        label: const Text(
          "Save Resume",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}