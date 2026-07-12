import 'package:flutter/material.dart';

class EducationCard extends StatefulWidget {
  final List<String> education;
  final Function(String) onAdd;
  final Function(int) onRemove;

  const EducationCard({
    super.key,
    required this.education,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
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
              "🎓 Education",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "B.Tech CSE - XYZ University (2024-2028)",
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

            if (widget.education.isEmpty)
              const Text(
                "No education added yet.",
                style: TextStyle(color: Colors.grey),
              ),

            ...List.generate(
              widget.education.length,
              (index) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.school,
                    color: Colors.blue,
                  ),
                  title: Text(widget.education[index]),
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