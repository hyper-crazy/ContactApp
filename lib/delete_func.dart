// lib/confirm_delete_dialog.dart

import 'package:flutter/material.dart';

Future<void> showConfirmDeleteDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Are you sure for Delete?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.blue),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: const Icon(Icons.delete, color: Colors.blue),
        ),
      ],
    ),
  );
}
