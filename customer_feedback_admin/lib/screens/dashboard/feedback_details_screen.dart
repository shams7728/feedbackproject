import 'package:customer_feedback_admin/models/feedback.dart';
import 'package:flutter/material.dart';

class FeedbackDetailsScreen extends StatelessWidget {
  const FeedbackDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedbackModel feedback = ModalRoute.of(context)!.settings.arguments as FeedbackModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Feedback Message", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              const SizedBox(height: 10),
              Text(
                feedback.message,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date: ${feedback.date}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}