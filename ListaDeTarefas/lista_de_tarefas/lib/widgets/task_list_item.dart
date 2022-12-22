import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/tasks.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.tasks,
    required this.onDelete,
  });

  final Tasks tasks;
  final Function(Tasks) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: (context) {
                onDelete(tasks);
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(tasks.dateTime),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                tasks.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
