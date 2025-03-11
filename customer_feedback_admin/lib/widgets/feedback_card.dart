import 'package:customer_feedback_admin/models/feedback.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackModel feedback;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FeedbackCard({
    super.key,
    required this.feedback,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(feedback.user, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(feedback.message, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 5),
            Text("Date: ${feedback.date}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.visibility, color: Colors.blue), onPressed: onView),
            IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}