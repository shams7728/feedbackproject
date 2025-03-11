import 'package:customer_feedback_admin/providers/FeedbackProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  _FeedbackListScreenState createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedbackProvider>(context, listen: false).fetchFeedback();
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.blueAccent,
      ),
      body: feedbackProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                  verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                columns: const [
                  DataColumn(label: Text('Index', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Feedback', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
                rows: List.generate(
                  feedbackProvider.feedbackList.length,
                      (index) {
                    final feedback = feedbackProvider.feedbackList[index];
                    return DataRow(cells: [
                      DataCell(Text((index + 1).toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      DataCell(Container(
                        width: 200, // Fixed width for better alignment
                        child: Text(feedback.message, overflow: TextOverflow.ellipsis),
                      )),
                      DataCell(Text(feedback.date)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/feedback_details',
                              arguments: feedback,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              // Implement Edit Function
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await feedbackProvider.deleteFeedback(feedback.id);
                            },
                          ),
                        ],
                      )),
                    ]);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
