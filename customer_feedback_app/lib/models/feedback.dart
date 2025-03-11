class FeedbackModel {
  final String id;
  final String user;
  final String message;
  final String status;
  final DateTime createdAt; // ✅ Added createdAt for sorting

  FeedbackModel({
    required this.id,
    required this.user,
    required this.message,
    required this.status,
    required this.createdAt, // ✅ Ensure this is included
  });

  // ✅ Factory constructor to handle JSON conversion
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? 'Unknown',
      message: json['message'] ?? 'No message',
      status: json['status'] ?? 'Pending',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(), // ✅ Handle invalid dates safely
    );
  }

  // ✅ Convert model back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "message": message,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
