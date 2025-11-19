import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String title;
  final String value;
  final bool editable;
  final Function(String value)? onEdit;

  const EditableField({
    super.key,
    required this.title,
    required this.value,
    this.editable = true,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = value.trim().isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    isEmpty ? "* Required" : value,
                    style: TextStyle(
                      color: isEmpty ? Colors.red : null,
                      fontStyle: isEmpty ? FontStyle.italic : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (editable && onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => _showEditDialog(context),
            ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: value);
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
}
