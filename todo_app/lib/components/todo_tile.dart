import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.taskName, required this.taskCompleted, required this.onChanged});

  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.amberAccent[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // checkbox
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.deepPurpleAccent[400],
            ),
            // task name
            Text(
              taskName, // TODO: add word wrapping for long text
              softWrap: true,
              style: TextStyle(
                fontSize: 16,
                decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
