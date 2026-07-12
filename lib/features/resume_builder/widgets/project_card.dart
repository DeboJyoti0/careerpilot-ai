import 'package:flutter/material.dart';

class ProjectsCard extends StatefulWidget {
  final List<String> projects;
  final Function(String) onAdd;
  final Function(int) onRemove;

  const ProjectsCard({
    super.key,
    required this.projects,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
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
              "🚀 Projects",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "CareerPilot AI",
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

            if (widget.projects.isEmpty)
              const Text(
                "No projects added yet.",
                style: TextStyle(color: Colors.grey),
              ),

            ...List.generate(
              widget.projects.length,
              (index) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.folder_open,
                    color: Colors.orange,
                  ),
                  title: Text(widget.projects[index]),
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