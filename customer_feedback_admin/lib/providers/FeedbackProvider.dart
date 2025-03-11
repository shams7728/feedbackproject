import 'package:customer_feedback_admin/models/feedback.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FeedbackProvider extends ChangeNotifier {
  List<FeedbackModel> feedbackList = [];
  bool isLoading = false;
  final ApiService _apiService = ApiService();

  // ✅ Fetch Feedback from API
  Future<void> fetchFeedback() async {
    isLoading = true;
    notifyListeners();
    try {
      feedbackList = await _apiService.getFeedback();
    } catch (e) {
      print("Error fetching feedback: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  // ✅ Delete Feedback
  Future<bool> deleteFeedback(String feedbackId) async {
    bool success = await _apiService.deleteFeedback(feedbackId);
    if (success) {
      feedbackList.removeWhere((item) => item.id == feedbackId);
      notifyListeners();
    }
    return success;
  }

  // ✅ Update Feedback
  Future<bool> updateFeedback(String id, String newMessage) async {
    bool success = await _apiService.updateFeedback(id, newMessage);
    if (success) {
      int index = feedbackList.indexWhere((item) => item.id == id);
      if (index != -1) {
        feedbackList[index] = FeedbackModel(
          id: id,
          user: feedbackList[index].user,
          message: newMessage,
          date: feedbackList[index].date,
        );
        notifyListeners();
      }
    }
    return success;
  }
}