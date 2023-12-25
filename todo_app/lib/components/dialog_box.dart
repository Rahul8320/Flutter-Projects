import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellowAccent[100],
      content: SizedBox(
        height: 120,
        child: Column(children: [
          // input task name
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
            ),
          ),
          // Save and cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // save button
              CustomButton(text: "Save", onPressed: onSave),

              // little gap
              const SizedBox(width: 8),

              // cancel button
              CustomButton(text: "Cancel", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
