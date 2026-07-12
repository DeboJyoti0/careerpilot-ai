import 'package:flutter/material.dart';

class ExperienceCard extends StatefulWidget {
  final List<String> experience;
  final Function(String) onAdd;
  final Function(int) onRemove;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "💼 Experience",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText:
                    "Flutter Intern - ABC Pvt Ltd (Jan 2025 - Present)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;

                    widget.onAdd(_controller.text.trim());
                    _controller.clear();
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (widget.experience.isEmpty)
              const Text(
                "No experience added yet.",
                style: TextStyle(color: Colors.grey),
              ),

            ...List.generate(
              widget.experience.length,
              (index) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.work_outline,
                    color: Colors.deepPurple,
                  ),
                  title: Text(widget.experience[index]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => widget.onRemove(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}