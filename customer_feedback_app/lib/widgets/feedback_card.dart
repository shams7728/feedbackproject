import 'package:customer_feedback_app/models/feedback.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ✅ Import for date formatting

class FeedbackCard extends StatelessWidget {
  final FeedbackModel feedback;
  final VoidCallback onEdit; // ✅ Edit function

  const FeedbackCard({super.key, required this.feedback, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback.message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              "Date: ${DateFormat('MMMM dd, yyyy – HH:mm').format(feedback.createdAt)}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: onEdit, // ✅ Edit button
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
