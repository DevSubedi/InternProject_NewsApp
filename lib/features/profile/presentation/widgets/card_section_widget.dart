import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  final String title;
  final List<String> values;
  final bool editable;
  final Function(String)? onEdit;
  final Function(List<String>)? onEditList;

  const CardSection({
    Key? key,
    required this.title,
    required this.values,
    this.editable = true,
    this.onEdit,
    this.onEditList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEmpty = values.isEmpty || values.every((e) => e.trim().isEmpty);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (editable && (onEdit != null || onEditList != null))
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      if (onEditList != null) {
                        _showMultiInputDialog(context);
                      } else if (onEdit != null && values.isNotEmpty) {
                        _showEditDialog(context, values.first);
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (isEmpty)
              const Text(
                "* Required",
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ...values.map(
              (v) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text("• $v"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (onEdit != null) onEdit!(controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showMultiInputDialog(BuildContext context) {
    final controllers = values.isEmpty
        ? [TextEditingController()]
        : values.map((v) => TextEditingController(text: v)).toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit $title"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controllers.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: controllers[index],
                decoration: InputDecoration(labelText: "$title ${index + 1}"),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controllers.add(TextEditingController());
              Navigator.pop(context);
              _showMultiInputDialog(context);
            },
            child: const Text("Add More"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (onEditList != null) {
                final updatedList = controllers
                    .map((c) => c.text.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
                onEditList!(updatedList);
              }
              Navigator.pop(context);
            },
            child: const Text("Save All"),
          ),
        ],
      ),
    );
  }
}
