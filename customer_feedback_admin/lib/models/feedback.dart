class FeedbackModel {
  final String id;
  final String user;
  final String message;
  final String date;

  FeedbackModel({
    required this.id,
    required this.user,
    required this.message,
    required this.date,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    print("Parsing Feedback JSON: $json"); // ✅ Debugging line

    return FeedbackModel(
      id: json['_id'] ?? '',
      user: json.containsKey('userId') && json['userId'] is Map<String, dynamic> && json['userId'].containsKey('name')
          ? json['userId']['name'] // ✅ Correctly extract user name
          : 'Unknown',
      message: json['message'] ?? 'No message',
      date: json['createdAt'] ?? '',
    );
  }
}
