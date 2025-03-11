import 'package:customer_feedback_app/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feedback_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/feedback_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  bool _isAscending = true; // ✅ Track sorting order

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedbackProvider>(context, listen: false).fetchFeedback();
    });
  }

  Future<void> _submitFeedback() async {
    if (_feedbackController.text.isEmpty) return;
    bool success = await Provider.of<FeedbackProvider>(context, listen: false)
        .submitFeedback(_feedbackController.text.trim());
    if (success) {
      _feedbackController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit feedback. Try again.')),
      );
    }
  }

  Future<void> _editFeedback(String id, String currentMessage) async {
    TextEditingController editController = TextEditingController(text: currentMessage);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Feedback"),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(labelText: "Updated Message"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              bool success = await Provider.of<FeedbackProvider>(context, listen: false)
                  .editFeedback(id, editController.text);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Feedback updated successfully!")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to update feedback.")),
                );
              }
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Feedback'),
        centerTitle: true,
        actions: [
          // ✅ Improved Sorting Button UI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: Icon(
                _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
              ),
              label: Text(
                _isAscending ? "Ascending" : "Descending",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  _isAscending = !_isAscending;
                  feedbackProvider.sortFeedback(_isAscending);
                });
              },
            ),
          ),

          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Improved Feedback Submission Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _feedbackController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Enter your feedback',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(text: 'Submit Feedback', onPressed: _submitFeedback),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Section Title
            const Text(
              'Previous Feedback:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Feedback List
            Expanded(
              child: feedbackProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: feedbackProvider.feedbackList.length,
                itemBuilder: (context, index) {
                  final feedback = feedbackProvider.feedbackList[index];
                  return FeedbackCard(
                    feedback: feedback,
                    onEdit: () => _editFeedback(feedback.id, feedback.message),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
