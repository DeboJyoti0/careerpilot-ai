import 'package:flutter/material.dart';

class SkillsCard extends StatefulWidget {
  final List<String> skills;
  final Function(String) onAdd;
  final Function(int) onRemove;

  const SkillsCard({
    super.key,
    required this.skills,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<SkillsCard> createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _controller.text.trim();

    if (skill.isEmpty) return;

    widget.onAdd(skill);

    _controller.clear();
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
              "🛠 Skills",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Flutter",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addSkill,
                ),
              ),
              onSubmitted: (_) => _addSkill(),
            ),

            const SizedBox(height: 20),

            if (widget.skills.isEmpty)
              const Text(
                "No skills added yet.",
                style: TextStyle(color: Colors.grey),
              ),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                widget.skills.length,
                (index) => Chip(
                  avatar: const Icon(
                    Icons.code,
                    size: 18,
                  ),
                  label: Text(widget.skills[index]),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => widget.onRemove(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}